# Picto

Email driven web image gallery

## Requirements
* Ruby 2.2.0
* ImageMagick
* Postgres
* Redis

## Instalation
```sh
$ git clone git@github.com:b0oh/picto.git
$ cd picto
$ bundle
$ cp config/config.yml.example config/config.yml
$ open config/config.yml
$ bundle exec rake db:create db:migrate
$ bundle exec rackup
```

## Running tests
```sh
$ RACK_ENV=test bundle exec rake db:create db:migrate
$ bundle exec rake
```

## Running workers
```sh
$ bundle exec sidekiq -c 5 -r ./lib/picto.rb
```

## API

### Possible responses

* 200 application/json
* 204
* 400 application/json

  ```httph-javascript
    { "error": {
        "status": "invalid_param",
        "message": "error message"
      }
    }
  ```

* 404 application/json

  ```http-javascript
    { "error": {
        "status": "not_found",
        "message": "not found"
      }
    }
  ```

* 422 application/json

  ```http-javascript
    { "error": {
        "status": "unprocessable_entity",
        "message": "error message"
      }
    }
  ```

### Get images:

Request: | &nbsp;     | &nbsp;
--------:|------------|------------
`offset` | _optional_ | Skip number of results from beginning.
`limit`  | _optional_ | Number of results to return per page.

```httph
GET: /api/images
```

**Response:**

```httph-javascript
Status: 200 OK

{ "images": [
    {
      "id": "abcdef",
      "url": "https://url-to-image",
      "width": 400,
      "height": 300,
      "user": {
        "id": 1,
        "email": "email"
      }
    }
  ],
  "pagination": {
    "total": 351,
    "count": 4,
    "offset": 347,
    "limit": 100
  }
}
```

### Post images:

Request:            | &nbsp;     | &nbsp;
-------------------:|------------|------------
`sender`            | _required_ | Sender's email.
`attachment-count`  | _optional_ | Number of sended attachments
`attachment-#{n}`   | _optional_ | Attachment as multipart data

```httph
POST: /api/images/post
```

**Response:**

```httph-javascript
Status: 204 OK
```
