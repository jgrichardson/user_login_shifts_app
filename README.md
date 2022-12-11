# USER LOGIN SHIFTS APPLICATION

This is a simple web application that allows users to sign in, sign out, and request some data this is specific to the currently logged-in user.

## Technology Stack (in production)

* Ubuntu v22.04 
* Puma v5.0
* Ruby v2.7.7
* Rails v6.1.7
* PostgreSQL v14
* Bulma CSS Framework

## Demo Site

This application is deployed to a production demo site, which can be accessed at:

[Demo Site](https://powerful-falls-42539.herokuapp.com/)

New users can be created by clicking on the All Users option in the nav bar. A default user is seeded with user_name "demo" and password "password".

New shifts can be created by clicking on the All Shifts option in the nav bar. Two default shifts for the demo user are seeded with the role "Chef".

After loggin in, clicking on the button labeled "My Shifts" will display a table with all shifts for the currently logged-in user.

## Web UI

This application includes a web UI that supports the following user actions:

* User Login
* User Logout
* CRUD Actions for All Users
* CRUD Actions for All Shifts
* View "My Shifts" for the Logged in User

## API Endpoints

This application exposes three RESTful, versioned (v1) API endpoints:

### POST / Sign_in

This endpoint expects a JSON-encoded body, with a user_name attribute and a password attribute. If a matching user is found, the server generates a unique session ID and include a Set-Cookie header in the response with the session ID. All subsequent requests that include this session ID cookie will be considered authenticated for the given user. If no matching user is found, the server should return a 401 error and a JSON error message

Example CURL request:
```
curl -d '{"user_name":"demo", "password":"password"}' \
  -H "Content-Type: application/json" \ 
  -X POST https://powerful-falls-42539.herokuapp.com/session/new
```

### DELETE /sign_out

This endpoint expects a session ID to be passed along via a cookie in the request headers. If a session ID is present in the cookies, the session ID is invalidated such that all subsequent requests with the session ID return a 401 error. If no session ID is present, the server returns a 401 (unauthorized) error.

Example CURL request:
```
  curl --cookie "session_id=68b25ff5-0785-4fdb-851c-1900dae3c24e" \
  -X DELETE https://powerful-falls-42539.herokuapp.com/session
```
### GET /shifts

This endpoint expects a session ID to be passed along via a cookie in the request headers. If a session ID is present in the cookies, and the session ID maps to a valid user, the server returnss a JSON array of all of the shifts that belong to the user. An example response:

```
[
  {
    "user_id": 1,
    "start_at: "2019-03-08T16:21:32Z",
    "end_at: "2019-03-08T19:21:24Z",
    "role": "Chef"
  },
  {
    "user_id": 1,
    "start_at: "2019-03-07T16:21:32Z",
    "end_at: "2019-03-07T19:21:24Z",
    "role": "Chef"
  }
]
```

If no session ID is present, the server returns a 401 error.

Example CURL request:
```
    curl --cookie "session_id=68b25ff5-0785-4fdb-851c-1900dae3c24e" \
    -X GET https://powerful-falls-42539.herokuapp.com/api/v1/users/1/shifts
```

## Testing

Tests can be run for the three endpoints:

```

```

# TO DO

* Password attribute in User model should be coverted to password_hash, with has_secure_password mixin added to User model, and Bcrypt used to encrypt password_hash

* API endpoints should be secured with JWT or another approach.

## License

The source code for the application is licensed under the MIT license, which you can find in the LICENSE file in this repo.
