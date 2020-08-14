# Simple API for processing videos
This are the docs for the API, all the resources and how to use it.

# Group Auth


## Login [api/v1/logins]
### Resource for Login
Endpoints for the Login


### Create and sign in user [POST /api/v1/logins]

+ Parameters
    + email: `` (string, required) - user email

+ Request returns http success
**POST**&nbsp;&nbsp;`/api/v1/logins`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            email=sam.thompson%40moore.name

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "csrf": "pBCBL/MoToY5JN9Spa3/KnxYY9jqgNvpx9xaqEYub/xGeQglrl+NHCKHyGf9nzkp0ew+J5vpiJOUzu6MGB1QQQ=="
            }

## Refresh [/api/v1/refreshs]
### Resource for Refresh
Endpoints for the Refresh


### Refresh access token for user [POST /api/v1/refreshs]


+ Request refreshes access token
**POST**&nbsp;&nbsp;`/api/v1/refreshs`

    + Headers

            X-CSRF-Token: rXK8quE66FYy34QefFsShuSmoJcT8rndrb71M5hvfR9AhYOHy/nUKDxcKP1Gzm5N39ZBooTi/QtHhHwAWyJtdQ==
            Content-Type: application/x-www-form-urlencoded

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "csrf": "5Ts8Du7CzMR6q+EKYESluxvu8eVurlV2XkCzKJ4OSFoAirkVDngrXH7CJNC6oq62wnY0bBdvDl2LKyZ0nWUz4g=="
            }

# Group Videos


## Videos [/api/v1/videos]
### Resource for Book
Endpoints for the video resource


### Upload video and send it to processing [POST /api/v1/videos.json]


+ Request uploads video and schedule for trimming
**POST**&nbsp;&nbsp;`/api/v1/videos.json`

    + Headers

            X-CSRF-Token: frL7j9FFmbc4QiZaUSiI6v1JM4vDYOWVgZIc0yEAagMUAXAcq8lQqGhcKfuPPGE5J4CsO23uDHIixo4u4hA6xQ==
            Content-Type: multipart/form-data; boundary=----------XnJLe9ZIbbGUYtzPQJ16u1

    + Body

            {
              "file": {
                "filename": "video.mp4",
                "type": "text/plain",
                "name": "file",
                "tempfile": "#<File:0x000055ad213fb0f0>",
                "head": "Content-Disposition: form-data; name=\"file\"; filename=\"video.mp4\"\r\nContent-Type: text/plain\r\nContent-Length: 17839845\r\n"
              },
              "start": "5",
              "end": "10"
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "data": {
                "id": "5f3696fb9fddf10357e8c594",
                "type": "video",
                "attributes": {
                  "status": "scheduled",
                  "duration": 30.526667
                },
                "links": {
                  "url": "/uploads/85afafc9e7928e50c362cd728c1d06f0.mp4"
                }
              }
            }

### Restart failed request [POST /api/v1/videos/{id}/restart.json]

+ Parameters
    + id: `5f3696fc9fddf10357e8c59e` (string, required)

+ Request restarts failed trimming
**POST**&nbsp;&nbsp;`/api/v1/videos/5f3696fc9fddf10357e8c59e/restart.json`

    + Headers

            X-CSRF-Token: 9t/99srN3VDK2M8hPRxZ2nZ6GriyxjiHCB3LZGt7RkByKXw16AH9bYAFLomkdD7f1WHBhb89e17lxZUYPf/ROQ==
            Content-Type: application/json

    + Body

            {
              "start": 5,
              "end": 10
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "data": {
                "id": "5f3696fc9fddf10357e8c59e",
                "type": "video",
                "attributes": {
                  "status": "scheduled",
                  "duration": 30.526667
                },
                "links": {
                  "url": "/uploads/ca1b6079ce3d9a1341b62ab9bf916337.mp4"
                }
              }
            }

+ Request fetchs list of user videos
**GET**&nbsp;&nbsp;`/api/v1/videos`

    + Headers

            X-CSRF-Token: rqMnAwVmBbnSzxamwEH8tQEyGi9B1s37Z4H4Ey9BUHZcxt7mcbAN7UvtG3CWh/tmwwh+b8KlK1TJZSiELdMNBw==

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "data": [
                {
                  "id": "5f3696fd9fddf10357e8c5a6",
                  "type": "video",
                  "attributes": {
                    "status": null,
                    "duration": 30.526667
                  },
                  "links": {
                    "url": "/uploads/9e37a252b954e5398e354e9f48761473.mp4"
                  }
                }
              ]
            }
