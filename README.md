# Signup Sumo

## Instant notifications when valuable people sign up to use your product or service.

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/signupsumo](https://assembly.com/signupsumo).

### How Assembly Works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assembly.com](https://assembly.com) to learn more.

### Project bootstrap

    git clone git@github.com:asm-products/signupsumo-web.git
    cd signupsumo-web
    bin/setup

### Run using Docker

- [Install Boot2Docker](http://boot2docker.io/)
- Run Boot2Docker
  - $ `boot2docker init`
  - $ `boot2docker start`
  - $ `$(boot2docker shellinit)`
  - To persist the environment variables across shell sessions, you can add `$(boot2docker shellinit)` to your `~/.bashrc` file
- [Install docker-compose (formerly fig)]http://docs.docker.com/compose/install)
  - ``curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose``
- Copy sample `database.yml`
  - $ `cp config/database.yml.sample config/database.yml`
- Copy sample `.env`
  - $ `cp .env.sample .env`
- Build the Docker containers
  - $ `docker-compose build`
- Run the app
  - $ `docker-compose up`
- Migrate the database
  - Do this in another terminal window
    - `docker-compose run web rake db:create db:migrate`
- Access the app locally
  - Run `boot2docker ip` to get the ip address of the Docker daemon
  - View the app at `IP_ADDRESS:3000`

#### Development notes

- If you modify the `Gemfile` or the `Dockerfile` you will need to run `docker-compose build` to rebuild the container.

