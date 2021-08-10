## About The Project
Read The Docs documentation for the SyMP framework

### Built With

* [Sphinx](https://www.sphinx-doc.org/en/master/)
* [Read The Docs Theme](https://sphinx-rtd-theme.readthedocs.io/en/stable/#)

## Getting Started

### Prerequisites

This project uses Docker to automatically build and setup the created service. Please make sure that you have Docker installed or follow the download instructions [here](https://docs.docker.com/docker-for-windows/install/).

### Installation
**Option 1: Run with Docker**

*Attention:* The dockerized build is already preconfigured 

   - One-Liner: Use `docker-compose up --build` to build the containers and start them directly
   - Use `docker-compose build` to build the containers.
   - Use `docker-compose up` to start the containers.

**Option 2: Running manually**

1. Installed Sphinx with pip `pip install sphinx` or use one of the other methods described [here](https://www.sphinx-doc.org/en/master/usage/installation.html).

2. Install the [Read The Docs Theme](https://github.com/readthedocs/sphinx_rtd_theme) with `pip install sphinx-rtd-theme`

3. Built with `make html`

## Usage

- If you've used the Docker method, the documentation should be available at http://localhost:8085

- If you've used the manual method, the generated documentation should be available in `/build/html` 

    *Note: Make sure that you host all of the files in the `build` folder on a webserver so that you get the full functionallity provided by Sphinx.*
