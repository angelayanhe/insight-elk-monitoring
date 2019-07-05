# Table of Contents

1. [Introduction](README.md#introduction)


## Introduction

The goal of this project is to explore detailed monitoring using ELK (Elasticsearch Logstash Kibana). None standard system and application logs could be transformed and consumed in this stack. The deployment of the monitoring infrastructure together with the application pipeline is automated onto AWS by writing infrastructure as code (IaC). Terraform, Packer and Docker are used for automatic deployment. Git is used for version control. We demonstrated the flexibility of consuming two types of logs: the netstat log collected from the system and the werkzeug log collected from the web application.

