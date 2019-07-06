# Table of Contents

1. [Project Introduction](README.md#project-introduction)
2. [Application Overview](README.md#application-overview)
3. [Data Pipeline](README.md#data-pipeline)
    * Data Extraction
    * Data Transformation
    * Data Loading
4. [Infrastructure Technology](README.md#infrastructure-technology)
	* Packer
	* Docker
	* Terraform

## Project Introduction

The goal of this project is to explore detailed monitoring using ELK (Elasticsearch Logstash Kibana). None standard system and application logs could be transformed and consumed in this stack. The deployment of the monitoring infrastructure together with the application pipeline is automated onto AWS by writing infrastructure as code (IaC). Terraform, Packer and Docker are used for automatic deployment. Git is used for version control. We demonstrated the flexibility of consuming two types of logs: the netstat log collected from the system and the werkzeug log collected from the web platform.

## Application Overview

The application for monitoring in this project is called AirAware (https://github.com/cheuklau/insight-zone-defense). AirAware is a web platform for querying air quality at arbitrary United States locations.

## Data Pipeline

### Data Extraction

The measurement data is available from EPA (https://aqs.epa.gov/aqsweb/airdata/download_files.html#Raw). The measurement data provides hourly pollutant levels at fixed stations throughout the United States. The amount of data for the years after 2000 is approximately 10GB/year. For the data extraction step, the data is downloaded into an Amazon Web Service (AWS) S3 storage bucket, then loaded into Spark for processing.

### Data Transformation

The data transformation step calculates the pollution level at 100,000 spatial points distributed throughout the United States such that any arbitrary address is at most 15 miles away from one of the grid points. The pollution level at each grid point is calculated by inverse-distance weighting of the measurement data at the fixed stations. Several additional metrics are also computed including monthly averages for further analysis. Note that to reduce computational costs, the distances between grid points and measurement stations were pre-computed.

### Data Loading

The processed data along with additional metrics from Spark are loaded into a PostgreSQL database. We also use the PostGIS extension in order to perform easier location-based search. The user interface is provided through a Flask application which allows the user to select an address and view the monthly-averaged data from PostgreSQL.

## Infrastructure Technology

### Packer

Packer is used to create the Amazon machine images (AMI) for the back bone components (i.e., Flask, Spark and PostgreSQL) of the data engineering pipeline. The AMIs use a base Ubuntu image and installs the required software.

### Docker

Docker images are used to build the monitoring components such as Logstash, Elasticsearch and Kibana. The service monitoring tools are build on top of a base Ubuntu image and hosted in AWS EC2 instance. 

### Terraform

Terraform is used to setup the virtual private cloud (VPC) and other security group settings. It is also used to spin up the AWS EC2 instances using the amazon machine images (AMIs) created by Packer and configures them accordingly. I also use terraform to spin up the monitoring instances using Docker images and configures them accordingly. 

The following figure illustrates the technology infrastructure for the whole project:
![Fig 1: Technology Infrastructure](/images/technology_infrastructure.png)





