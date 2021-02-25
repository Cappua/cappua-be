<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)

# Cappua BE

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install](#how-to-install)
  - [Dependencies](#dependencies)
  - [Learning Goals](#learning-goals)
  - [API Contract](#api-contract)
  - [Licenses](#licenses)
  - [Contact](#contact)
  
## What it does

> This project follows Service-Oriented Architecture (SOA) that provides users with GraphQL endpoints that can be called in the Cappua FE.

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

## API Contract

Our BE API uses a combination of ReSTful endpoints and GraphQL queries. Our single ReSTful endpoint, `POST /upload`, handles audio file uploads into our nested AWS S3 bucket, and creates related entries in our database. Our GraphQL queries handle all the rest of our CRUD functionality.

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
|  Rules          |  String       |   (required for competition uploads) - Genre of the competition to be shown on the competitions page        |

#### Sample Response (type => 'verse')

```
# Raw JSON
"{\"data\":{\"id\":\"222\",\"type\":\"verse\",\"attributes\":{\"id\":222,\"audio_path\":\"verses/es_zone_in.mp3\",\"competition_id\":212,\"user_id\":295,\"title\":\"Just a Friend\"}}}"

# Parsed JSON
{:data=>
  {:id=>"210",
   :type=>"verse",
   :attributes=>
    {:id=>210,
     :audio_path=>"verses/es_zone_in.mp3",
     :competition_id=>204,
     :user_id=>283,
     :title=>"Just a Friend"}}}
```

#### Sample Response Body (type => 'competition')

```
# Raw JSON
"{\"data\":{\"id\":\"210\",\"type\":\"competition\",\"attributes\":{\"id\":210,\"track_path\":\"competitions/es_zone_in.mp3\",\"month\":2,\"year\":2021}}}"

# Parsed JSON
{:data=>
  {:id=>"207",
   :type=>"competition",
   :attributes=>
    {:id=>207,
     :track_path=>"competitions/es_zone_in.mp3",
     :month=>2,
     :year=>2021}}}
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
    verses { verseType }
  }
}
```

#### Sample Response Body

```
# Raw JSON
"{\"data\":{\"competition\":{\"id\":\"213\",\"trackPath\":\"http://stiedemann.biz/thurman\",\"month\":7,\"year\":2021,\"description\":\"Pidgeot\",\"genre\":\"Struggle\",\"rules\":\"Anistar City\",\"verses\":[{\"id\":\"223\"},{\"id\":\"224\"}]}}}"

# Parsed JSON
{:data=>
  {:competition=>
    {:id=>"213",
     :trackPath=>"http://stiedemann.biz/thurman",
     :month=>7,
     :year=>2021,
     :description=>"Pidgeot",
     :genre=>"Struggle",
     :rules=>"Anistar City",
     :verses=>[{:id=>"223"}, {:id=>"224"}]
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
### Raw JSON
"{\"data\":{\"verses\":[{\"id\":\"231\",\"audioPath\":\"http://zemlak.co/rickey\",\"competitionId\":217,\"userId\":304,\"title\":\"Yog-Sothoth\"},{\"id\":\"232\",\"audioPath\":\"http://hauck.io/jocelyn\",\"competitionId\":218,\"userId\":305,\"title\":\"Azathoth\"},{\"id\":\"233\",\"audioPath\":\"http://lowe.org/sherry.feeney\",\"competitionId\":219,\"userId\":306,\"title\":\"Tsathoggua\"},{\"id\":\"234\",\"audioPath\":\"http://hackett-welch.co/gricelda_barton\",\"competitionId\":220,\"userId\":307,\"title\":\"Dagon\"}]}}"

### Parsed JSON
{:data=>
  {:verses=>
    [{:id=>"231",
      :audioPath=>"http://zemlak.co/rickey",
      :competitionId=>217,
      :userId=>304,
      :title=>"Yog-Sothoth"},
     {:id=>"232",
      :audioPath=>"http://hauck.io/jocelyn",
      :competitionId=>218,
      :userId=>305,
      :title=>"Azathoth"},
     {:id=>"233",
      :audioPath=>"http://lowe.org/sherry.feeney",
      :competitionId=>219,
      :userId=>306,
      :title=>"Tsathoggua"},
     {:id=>"234",
      :audioPath=>
       "http://hackett-welch.co/gricelda_barton",
      :competitionId=>220,
      :userId=>307,
      :title=>"Dagon"}]}}
```

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
