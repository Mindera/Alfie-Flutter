# Alfie Flutter 
This is a repository for an e-commerce Flutter app template. Its current behavior can be seen in the following demonstration:

<!-- TODO DEMONSTRATION VIDEO -->

## Prerequisites
1. This project uses a mock GraphQL API for fetching data. Mock server can be run locally as described in documentation: https://github.com/Mindera/Alfie-Mocks
2. This project uses two .env files: `.env.dev` and `.env.prod`. Both need a variable `GRAPHQL_SERVER` with a URL to the mock server.

## Architecture 

This project uses the MVVM architecture model as reccommended by the [Flutter Documentation](https://docs.flutter.dev/app-architecture/guide).


### View

- Can be composed by multiple widgets.
- Shouldn't have bussiness logic.
- Can have animation logic, simple routing logic, and if-else statements to choose wich widget to render.

### View Model

- Should serve the View with presentation ready domain data.
- Should expose methods for use of the view.

**Important Note:** Views and View Models must have a one-to-one relationship.


### Repositories 

- Repositories are the middleground between view models and services. 
- Should transform raw data into domain objects.
- Should expose methods that ease the access of data.

### Services

- Services are the entry point of the application.
- Should abstract external factors like APIs and Local files

<br></br>
![alt text](Docs/mvvm_diagram.png)

_Note: For more detail go see the flutter documentation._

## Setting Up the Project

## GraphQL

## CI/CD

## Release

**Work in progress**

---