# 🚀 Getting started with Innovit ecommerce

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/dev-docs/cli) (CLI) which lets you scaffold and manage your project in seconds.

### `develop`

Start your Strapi application with autoReload enabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-develop)

```
npm run develop
# or
yarn develop
```

### `start`

Start your Strapi application with autoReload disabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-start)

```
npm run start
# or
yarn start
```

### `build`

Build your admin panel. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-build)

```
npm run build
# or
yarn build
```

### `create database`

```
docker exec -it strapiDB bash

psql

CREATE DATABASE innovit-ecommerce OWNER postgres;
```

### `graphql query`

```
http://localhost:1337/graphql

query {
  messages {
    data {
      id
      attributes {
        greetings
        createdAt
        updatedAt
      }
    }
  }
}

query {
  messages {
    data {
      id
      attributes {
        greetings
      }
    }
  }
}

query {
  message(id: "1") {
    data {
      id
      attributes {
        greetings
      }
    }
  }
}
```
