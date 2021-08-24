***********
Get Started
***********

The aim of this section is to give you an overview how the SyMP framework is implemented. Additionally, it could be used as a 
guide when setting up and configuring the environment for the SyMP services. More specific information about the inner workings
of the services is also available in the further sections.

Introduction
============

The SyMP framework utilizes the microservices architecture pattern, so that each building block of the framework can be devided
into small, independent, and loosely coupled service, which can be deployed as a distributed system. For better service maintanace 
and visibility, this is achieved by packing them into containers and building container orchestration, which represent the SyMP services.

.. note::
    This guide is created for build under Linux

What you need
=============

For the ease of use in the futer, during development one of the main goals were build automation and reproducibility. The automatic build is created 
with the help of Docker - a capable virtualization and packaging software, thus making it the only component needed to get the framework 
running. The following links will lead to you to the latest official installation guides of Docker and any additional plugins:

* `Docker <https://docs.docker.com/get-docker/>`_
* `Docker-Compose <https://docs.docker.com/compose/install/>`_

.. note::
    Docker is a cross-platform software, which makes SyMP framework independent of OS by default.
    
    Make sure your installation of Docker and Docker-Compose are working by executing ``docker -v`` and ``docker-compose -v`` and checkig the 
    output of the commands. If the software is installed propperly, you should be able to get the version of your Docker and Docker-Compose installation.

Next up, you need a copy of each SyMP service. You can download them from their repositories:

* `Security Analysis Engine <https://github.com/FlorianPatzer/symp_security_analysis_engine>`_
* `System Model Engine <https://github.com/FlorianPatzer/symp_system_model_engine>`_
* `System Client <https://github.com/FlorianPatzer/symp_client>`_
* `Analysis Hub <https://github.com/FlorianPatzer/symp_analysis_hub>`_

.. todo::
    Add a link when the repositories are created:

    1. SyMP Base
    2. SyMP Ingress
    3. FW Efective Configuration Worker

Step 1. Created a Docker network for the containers
===================================================

The SyMP services are configured to run in a Docker network called ``symp``, which must be created before starting them. To create it, execte the following command ``docker network create symp``.

Step 2. Configure the environment files and generate SSL certificates
=====================================================================

1. Navigate to the folder  SyMP Ingress repo

    Execute the script located in ``nginx\create_keys.sh`` and follow the steps.

2. Navigate to the folder  SyMP Client repo

    * Navigate to the ``backend\src\ssl`` folder and execute ``create_keys.sh``
    * Additionally you can configute the ``backend\src\keys.js`` file by changing the jwt and session secret for better security.

3. Navigate to the folder SyMP SAE repo

    * Navigate to ``security-analysis-engine/src/main/resources``
    * Execute the ``createTruststore.sh`` script in the ``keystores`` folder. Note the **password for the created trust store**.
    * Execute the ``create_keys.sh`` script in the ``ssl`` folder. Note the **password for the created key store**.
    * In the ``application.properties`` file add the **password for the key store** in the ``server.ssl.key-store-password`` field.
    * In the ``application.properties`` file add the **password for the trust store** in the ``truststore.custom.password`` field.
    * In the ``application.properties`` file write a secret for the JWT in the ``jwt.secret`` field.

4. Navigate to the folder  SyMP Base repo
    
    The FTP server needs also certificate for a secured connection. Execute the script located in ``ftp\ssl\create_keys.sh`` and follow the steps to create one.


Step 3. Build and start the containers
======================================

Each service has it's own Dockerfile which is complemented with an additional docker-compose file. The Dockerfile is describing the build process of an image (i.e. 
which services have to be downloaded, which ports have to be opened, which environmental variables are present, etc.), while the docker-compose file is configuring the a
container of the created image.

Run ``docker-compose up --build`` in each SyMP service to make sure that the newest version of the image is build and a container is started with it. 


.. note::

    Use the following sequence to ensure that the framework will start propperly:

    1. Base
    2. SAE
    3. Client
    4. AH
    5. SME
    6. FW Effective Configuration Worker
    7. Ingress

Step 4. Check service availability
==================================

You can check the service availability manually by pinging the open ports of the service containers. The following table presents the ports on which the services are running.

+------------------------+----------------------+-------------------------------------------+
| Service Name           | Docker Container     | Exposed Ports                             |
+========================+======================+===========================================+
| Analysis Hub           | symp-ah              | 8545                                      |
+------------------------+----------------------+-------------------------------------------+
| Neo4j                  | symp-neo4j           | 7474, 7678                                |
+------------------------+----------------------+-------------------------------------------+
| Fuseki                 | symp-fuseki          | 3030                                      |
+------------------------+----------------------+-------------------------------------------+
| SAE                    | symp-sae             | 8543                                      |
+------------------------+----------------------+-------------------------------------------+
| SME                    | symp-sme             | 8544                                      |
+------------------------+----------------------+-------------------------------------------+
| SME GUI                | symp-sme-gui         | Exposed with the ingress service          |
+------------------------+----------------------+-------------------------------------------+
| Client Frontend        | symp-client-frontend | Exposed with an additional nginx service  |
+------------------------+----------------------+-------------------------------------------+
| Client Backend         | symp-client-backend  | Exposed with an additional nginx service  |
+------------------------+----------------------+-------------------------------------------+
| Client (nginx proxy)   | symp-client          | 80                                        |
+------------------------+----------------------+-------------------------------------------+
| Mongo                  | symp-mongo           | 27017                                     |
+------------------------+----------------------+-------------------------------------------+
| FTP                    | symp-ftp             | 20, 21, 21100-21110                       |
+------------------------+----------------------+-------------------------------------------+
| Camunda                | symp-camunda         | 8080                                      |
+------------------------+----------------------+-------------------------------------------+
| MySQL                  | symp-mysql           | 3306                                      |
+------------------------+----------------------+-------------------------------------------+
| Filezilla Client       | symp-filezilla       | 5800                                      |
+------------------------+----------------------+-------------------------------------------+
| Ingress                | symp-nginx           | 80, 443                                   |
+------------------------+----------------------+-------------------------------------------+

Additional: Startup scripts
===========================

.. todo::
    Add link to the symp-helpers repo when it's created in GitHub.

The symp-helpers repo aims to automate the initial start of the services. The only prerequisite is Step 2. After setting up the environment config files and generating ssl certificates
you can proceede forward with the following steps:

1. Configure the repositories URL and the branch or the tag which you want to clone in the ``repositories.config`` file.
2. Run the ``cloneAll.sh`` script to clone all of the repositories.
3. Perform the actions described in ``Step 2. Configure the environment files and generate SSL certificates``

.. note::
    The repositories are cloned one directory up (i.e. in the folder where the symp-helpers folder is created). It's advisable
    to craete a separate folder (for example called ``SyMP``) to contain the cloned repositories of the SyMP framework. Here is an example directory tree:
    
    | SyMP/ 
    | ├─ symp-helpers/ 
    | ├─ .../ 
    | ├─ .../ 
    | ├─ .../ 

3. Afterwards run the ``runAll.sh`` script and wait it to finish. It will create a network of the services, pull all of the needed images for them and start and configure their containers.
The only additional step needed is to set up connect the client to the endpoints of the services and register an analysis engine. It is described in the next section.  