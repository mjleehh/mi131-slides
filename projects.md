# MI131 Class Project

A successfull project is required to be granted the ECTS credits for MI131.

## General

Each project should cover an entire server/client stack. 
- the entire stack must be implemented in Javascript (≥ ES6)
- package management must be done using `npm` 

All Projects are to be done in groups of 4. Each group has to hold a short (15 minutes) final project presentation at
the end of the term. This presentation should consist of:

1. Checking out the project afresh and building.
2. Running the test suite for both server and client.
3. Presenting the software in use.
4. Discussing a little bit of code and talking about design choices and some issues that came up during developement.

General requirements for the project setup:
- code must be placed in a public Github repo
- evolution of the project must be visible through small commits
- both client and server must provide `Mocha`/`Chai` testing
- all tests must automatically run on TravisCI on each commit
- checked out and built on a new machine the project must be runnable and deployable
    1. web apps can be bundled
    2. server runs and provides API and web apps
    3. `Cordova` apps must run on emulator 
    
What you can expect to find on a checkout:
- `npm` (≥ 3,5)
- `NodeJS` (≥ 6.11)
- `MongoDB` (≥ 3.4)
- `Cordova` (≥ 7.1)
- `Android SDK` (8.0)
- Android Virtual Device (Nexus 5X SDK 26)

#### Grading System

Some remarks on what is going to determine grades (in order of importance):
- functioning software
- explaining design choices (code and user flow)
- usability of the software
- code quality (readable and comprehensible) 
- test coverage
- small and well explained git commits (single line commit message)
- feature richness

It is more important to provide running software than a completed project. Better provide a well done feature subset, 
than a badly done completed project.

#### Client

The client should be implemented using (exceptions may be granted):
   
    -  `Webpack`
    -  `React`
    -  `Redux`
    -  `socket.io`

The client data model has to be placed in a `Redux` store and should be well designed an normalized to ensure good
interaction with the backend REST API. Actions and reducers should be defined to reflect all the users actions and make
the user interface debuggable through message logging. Careful and robust handling of async events is expected.

Mobile apps have to be bundled using `Cordova`.

#### Server

The server should be implemented using:
    
    - `MongoDB`
    - `Mongoose`
    - `Express` or `Koa`

The API has to follow REST principles and may use websockets for push updates to clients. Transactions should be kept
as atomic as possible through the use of `MongoDB` queries. Use `Mongoose` schemas to ensure typing in the database.
  