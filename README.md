<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)

# Cappua BE

![logo](https://user-images.githubusercontent.com/68172332/109255025-6d803400-77b0-11eb-82a9-e552c81a5661.png)

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install](#how-to-install)
  - [Dependencies](#dependencies)
  - [Learning Goals](#learning-goals)
  - [Project Diagram](#project-diagram)
  - [Schema](#schema)
  - [API Contract](#api-contract)
  - [Licenses](#licenses)
  - [Backend Team](#backend-team)
  - [Contact](#contact)
  
## What it does

### The Cappua App

> One part crowdsourced songwriting, one part rap battle, Cappua is a monthly hip hop music competition app in which users compete to get their verse included in the given month's featured track. Users upload their verse for a month's track and vote on their favorite uploaded verses as they vie for their place on Olympus, the Cappua Hall of Fame.

### The Cappua BE Repo

> The Cappua BE repo creates both GraphQL queries and a ReSTful endpoint for the FE repo to access data. This repo handles audio file uploads to the Cappua AWS S3 bucket, and stores the S3 bucket file locations for easy FE access via the AWS Cloudfront CDN. Finally, the repo stores vote data and user data in its relational database.

## How to Install

For usage on your local machine follow the instructions listed below:

```
git clone git@github.com:Cappua/cappua-be.git
cd cappua-be
bundle install
rake db:{create,migrate,seed}
figaro install
rails server
visit localhost:3000 in your web browser
```

## Dependencies

* This app uses Rails version `5.2.4.4`

* We use the [AWS SDK for Ruby Gem](https://github.com/aws/aws-sdk-ruby) to upload audio files to our AWS S3 Bucket.

* We use the [Figaro Gem](https://github.com/laserlemon/figaro) to keep confidential information like API keys secure.

* We use the [Fast JSON API Gem](https://github.com/Netflix/fast_jsonapi) to serialize data for our ReSTful `POST /upload` endpoint.

* The [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem was used to ensure that we covered 100% of our code with unit testing. 


## Learning Goals

  * Explore and integrate AWS services
  
  * Gain familiarity and confidence in working with full FE & BE teams
  
  * Incorporate agile processes such as standups and kanban boards
  
  * Create versatile GraphQL queries
  
  * Refactor code for better code for improved organization/readability

  * Iterate upon collaborative workflow with small commits, descriptive pull requests, and code reviews

  * Write thorough and understandable documentation

## Project Diagram

![Cappua Diagram (1)](https://user-images.githubusercontent.com/68172332/109397255-19319d00-78f3-11eb-8348-9562657e240e.png)

## Schema

<img width="968" alt="Screen Shot 2021-02-25 at 10 13 48 PM" src="https://user-images.githubusercontent.com/68172332/109258167-f5693c80-77b6-11eb-95a6-7e564a898cec.png">

## API Contract

Our BE API uses a combination of a ReSTful endpoint and GraphQL queries. Our single ReSTful endpoint, `POST /upload`, handles audio file uploads into our nested AWS S3 bucket, and creates related entries in our database. Our GraphQL queries handle all the rest of our CRUD functionality.

### POST /upload - ReSTful Endpoint

POST /upload allows for the upload of audio files and the creation of both competition and verse rows in our BE database. The required parameter `type` is used to define which of these two functions will be performed. Parameters must be passed in with a `multipart/form-data` content type header.

#### Request Parameters

|     Name        |      Type     |   Description                                                                                               |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
|  type           |  String       |   (required) `'verse'` or `'competition'` to specify what kind of file is being uploaded                    |
|  audio          |  mp3          |   (required) Audio file to be uploaded                                                                      |
|  user_id        |  Integer      |   (required for verse uploads) - the id of the user that is uploading a verse                               |
|  competition_id |  Integer      |   (required for verse uploads) - the id of the competition that a verse is being uploaded for               |
|  title          |  String       |   (required for verse uploads) - the name of the verse                                                      |
|  Month          |  Integer      |   (required for competition uploads) - Numeric Representation (1 - 12) of the month competition is held in  |
|  Year           |  Integer      |   (required for competition uploads) - Numeric Representation of the year competition is held in            |
|  Description    |  String       |   (required for competition uploads) - Description of the competition to be shown on the competitions page  |
|  Genre          |  String       |   (required for competition uploads) - Genre of the competition to be shown on the competitions page        |
|  Rules          |  String       |   (required for competition uploads) - Rules for the competition to be shown on the competitions page       |
|  Title          |  String       |   (required for competition uploads) - Title of the competition to be shown in the media player             |
|  Image          |  String       |   (optional for competition uploads) - Image of the competition to be shown on the competitions page        |

#### Sample Response (type => 'verse')

```
{
  "data": {
    "id": "210",
    "type": "verse",
    "attributes": {
      "id": "210",
      "audio_path": "verses/es_zone_in.mp3",
      "competition_id": "204",
      "user_id": "283",
      "title": "Just a Friend"
     }
   }
 }
```

#### Sample Response Body (type => 'competition')

```
{
  "data": {
    "id": "207",
    "type": "competition",
    "attributes": {
      "id": "207",
      "track_path": "competitions/es_zone_in.mp3",
      "month": "2",
      "year": "2021",
      "description": "Wu Tang Sword Style",
      "genre": "East Coast Hip Hop",
      "rules": "Submissions due by February 14th. Winners announced on March 1st",
      "title": "Wu Tang Forever",
      "image": "https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg"
    }
  }
}
```

### Competitions Query - GraphQL

#### Request Query

```
query {
  competitions {
    id
    trackPath
    month
    year
    description
    genre
    rules
    title
    image
    verses { verseType }
  }
}
```

#### Sample Response Body

```
{
  "data": {
    "competition": {
      "id": "213",
      "trackPath": "http://stiedemann.biz/thurman",
      "month": "7",
      "year": "2021",
      "description": "Pidgeot",
      "genre": "Struggle",
      "rules": "Anistar City",
      "title": "Wu Tang Forever",
      "image: "https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg"
      "verses": [
        {"id": "223"},
        {"id": "224"}
      ]
    }
  }
}
```

### Verses Query - GraphQL

#### Request Query

```
query {
  verses {
     id
    competitionId
    userId
    audioPath
    user { userType }
    votes { voteType }
    track { trackType }
  }
}
```

#### Sample Response Body

```
{
  "data": {
    "verses": [
      {
        "id": "231",
        "audioPath": "http://zemlak.co/rickey",
        "competitionId": "217",
        "userId": "304",
        "title": "Yog-Sothoth"
      },
      {
        "id": "232",
        "audioPath": "http://hauck.io/jocelyn",
        "competitionId": "218",
        "userId": "305",
        "title": "Azathoth"
      },
      {
        "id": "233",
        "audioPath": "http://lowe.org/sherry.feeney",
        "competitionId": "219",
        "userId": "306",
        "title": "Tsathoggua"
      },
      {
        "id": "234",
        "audioPath": "http://hackett-welch.co/gricelda_barton",
        "competitionId": "220",
        "userId": "307",
        "title": "Dagon"
      }
    ]
  }
}
```

### createVote mutation - GraphQL

#### Request Query

```
mutation {
  createVote( input: { verseId: ID, userId: ID }) {
      id
      userId
      verseId
    }
  }
}
```

#### Sample Response

```
{
  "data": {
    "createVote": {
      "id": "<integer>"
        "verseId": "<integer>",
        "userId": "<integer>"
    }
  }
}
```

## Licenses

  * Ruby 2.5.3
  * Rails 5.2.4.4

## BackEnd Team

<h4>Brian Liu</h4>
<img src="https://avatars.githubusercontent.com/u/67594471?s=460&u=55cc76d3d09defb7d0bc2c8f434d75cfca7d8076&v=4" alt="Brian Liu"
 width="150" height="auto" style="float: left" />

[GitHub Profile](https://github.com/the-color-bliu)

<h4>Eugene Theriault</h4>
<img src="https://avatars.githubusercontent.com/u/45305677?s=460&u=916234021c3105b868dd45a2660ec873d7f7d045&v=4" alt="Eugene Theriault"
 width="150" height="auto" style="float: left" />

[GitHub Profile](https://github.com/ETBassist)

<h4>Nick King</h4>
<img src="https://avatars.githubusercontent.com/u/68172332?s=460&u=8b0b3766e31ff6be0d1dea0a8591483dc1bdd870&v=4" alt="Nick King"
 width="150" height="auto" style="float: left" />

[GitHub Profile](https://github.com/nmking22)

<h4>Sage Freeman-Gonzales</h4>
<img src="https://avatars.githubusercontent.com/u/65799246?s=460&u=67367b4bf3eb0785908f7b7892abcc67efdf458c&v=4" alt="Sage Freeman-Gonzales"
 width="150" height="auto" style="float: left" />

[GitHub Profile](https://github.com/SageOfCode)
  
## Contact

#### Brian Liu: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/brian-liu-8356287b/)  [Email](mailto:brian.b.liu@gmail.com), [GitHub](https://github.com/the-color-bliu)
#### Cooper Terrones: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/cooper-terrones-39b508185/)  [Email](mailto:cooper.terrones@outlook.com), [GitHub](https://github.com/coopterrones)
#### Demaceo Vincent Howard: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/demaceo/) [Email](Hdemaceo@gmail.com),  [GitHub](https://github.com/demaceo)
#### Eugene Theriault: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/eugene-theriault/)  [Email](mailto:hybridbassist@gmai.com), [GitHub](https://github.com/ETBassist)
#### Nick King: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/anickking/)  [Email](mailto:nickmaxking@gmail.com), [GitHub](https://github.com/nmking22)
#### Sage Freeman-Gonzales: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sagefreemangonzales/)  [Email](mailto:sagegonzales15@gmail.com), [GitHub](https://github.com/SageOfCode)

<!-- MARKDOWN LINKS -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
