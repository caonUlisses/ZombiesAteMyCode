# ZombiesAteMyCode
Keeping an (active) record of infected people and helping with some trades.

## Help us survive

The world ended, but good practices are still a thing. :pray:
Our domain is pretty simple, so shall be our code!

For those who want to contribute, follow below:

#### Keep the models safe!

This is a goold-old boring rails app, following the moto **'Fat models, skinny controllers'**.
Zombies like some meat, so by keeping the outer layer (controllers) skinny, we keep our fat models safe.

#### But they can't run!!!1!

Whenever a model gets too fat, break it down (don't you dare just moving some methods to a module).
Do so by extracting value and service objects.
Our time is nye, so don't over over-engineer.

#### Avoid collision!

We may loose connection soon, so keep on using **UUIDs as primary keys**. 
When offline, keeping things in sync without UUIDS is madness!!1!

## See it live!

Not right now

## Documentation
You can find the documentation at `/docs`

## Testing

Alright, the `/docs` didn't make you happy and you're in a hush, I get it!
Navigate do `examples` and you'll find a lot of examples redy for use!

> Pro tip: Using [httpie](https://httpie.org/) will make your life easier.

## Running locally

You'll need [docker](https://www.docker.com/) and ruby 2.7.1.

Docker is there so you can isolate [postgresql](https://www.postgresql.org/) from your system and avoid [breaking dev and prod parity](https://12factor.net/).
Ruby is installed locally for development ergonomics/hapiness.
