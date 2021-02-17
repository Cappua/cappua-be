<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)

# Cappua BE

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install](#how-to-install)
  - [Dependencies](#dependencies)
  - [Learning Goals](#learning-goals)
  - [Licenses](#licenses)
  - [Contact](#contact)
  
## What it does

> This project follows Service-Oriented Architecture (SOA) that provides users with GraphQL endpoints that can be called in the Caaua FE.

## How to Install

For usage on your local machine follow the instructions listed below:

```
git clone git@github.com:Cappua/cappua-be.git
cd cappua-be
bundle install
rake db:{create,migrate}
firgaro install
rails server
visit localhost:3000 in your web browser
```

## Dependencies

* This app uses Rails version `5.2.4.4`

* We use the [Faraday Gem](https://github.com/lostisland/faraday) to make calls to our API service.

* We use the [Figaro Gem](https://github.com/laserlemon/figaro) to keep confidential information like API keys secure.

* The [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem was used to ensure that we covered 100% of our code with unit testing. 


## Learning Goals

  * Consume external APIs

  * Refactor code for better code for improved organization/readability

  * Utilize workflow: small commits, descriptive pull requests and code review

  * Write thorough and understandable documentation

## Licenses

  * Ruby 2.5.3
  * Rails 5.2.4.4
  
## Contact

#### Brian Liu: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sagefreemangonzales/)  [Email](mailto:brian.b.liu@gmail.com), [GitHub](https://github.com/the-color-bliu)
#### Cooper Terrones: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sagefreemangonzales/)  [Email](mailto:cooper.terrones@outlook.com), [GitHub](https://github.com/coopterrones)
#### Demaceo Vincent Howard: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sagefreemangonzales/)  [Email](mailto:sagegonzales15@gmail.com), [GitHub](https://github.com/demaceo)
#### Eugene Theriault: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/eugene-theriault/)  [Email](mailto:sagegonzales15@gmail.com), [GitHub](https://github.com/ETBassist)
#### Nick King: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/anickking/)  [Email](mailto:nickmaxking@gmail.com), [GitHub](https://github.com/nmking22)
#### Sage Freeman-Gonzales: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sagefreemangonzales/)  [Email](mailto:sagegonzales15@gmail.com), [GitHub](https://github.com/SageOfCode)

<!-- MARKDOWN LINKS -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
