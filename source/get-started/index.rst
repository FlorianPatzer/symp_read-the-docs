***********
Get Started
***********

The aim of this section is to give you an overview how the SyMP framework is implemented. Additionally, it could be used as a 
guide when setting up and configuring the environment for the SyMP services. More specific information about the inner workings
of the services is also available in their own sections.

Introduction
============

The SyMP framework utilizes the microservices architecture pattern, so that each building block of the framework can be devided
into small, independent, and loosely coupled service, which can be deployed as a distributed system. For better service maintanace 
and visibility, this is achieved by packing them into containers and building container orchestration, which represent the SyMP services.

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

Next up, you need a copy of each of the SyMP services. You can download them from their repositories:

.. todo::
    Add a link to the external repositories

* Security Analysis Engine
* System Model Engine
* System Client
* Analysis Hub

Step 1. Build and start the containers
======================================

Each of the services has it's own Dockerfile which is complemented with an additional docker-compose file. The Dockerfile is describing the built process of an image(i.e. 
which services have to be downloaded, which ports have to be opened, which environmental variables are present etc.), while the docker-compose file is configuring the a
container of the created image.

Run ``docker-compose up --build`` in each folder of the SyMP services to make sure that the newest version of the image is build and a container is started with it. Use the
following sequence to make sure that the framework will start propperly.

.. todo::
    Check the starting order from the helper scripts and add it here.

Step 2. Check service availability
==================================

.. todo::
    Add the table with the service address links, that is present in the GitLab Readmes.

Step 3. Configure services
==========================

.. todo::
    Make screenshots with the needed input and also copy any additional information from the GitLab Readmes


Additional: Startup scripts
===========================

.. todo::
    Describe the present scripts and their advantages and disadvantages.