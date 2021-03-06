# Urbit Docker

Alpine-based docker image for running [urbit](https://urbit.org/) (v1.1).

##### Get Started _Fast_:

```shell
$ docker run -it --rm -P jmnsf/urbit
```

This command will get you bootstrapped with a brand new &mdash; but discardable &mdash; comet + ship. After booting you can `docker ps` to see which ports Landscape is bound to.

## Persistent Runs

Tired of mining comets, or brought your own planet/star/galaxy? This part's for you.

### Persistent Comets

You can create a new comet in a ship called `comet` that is persisted across runs just by mounting a volume in your container:

```bash
$ docker run -it --rm -P -v urbit:/opt/urbit jmnsf/urbit
```

While this will get you started, it'll error out on subsequent runs because your comet's created already. Just change the command slightly:

```bash
$ docker run -it --rm -P -v urbit:/opt/urbit jmnsf/urbit comet
```

### Persistent Planets

You can run any command from the [install guide](https://urbit.org/using/install/) through this docker image, so you only have to make sure you're mounting your key files in a way that's accessible to the running container, and mounting the urbit state to a volume so it's persisted across runs.

If your key is in the current working dir in a file `keyfile`, the command would be:

```bash
$ docker run -it --rm -P -v urbit:/opt/urbit -v ./keyfile:/etc/urbit/keyfile jmnsf/urbit -w yourplanet -k /etc/urbit/keyfile
```

## Options

### Change Ports

You can replace the `-P` option from the commands above by custom port mappings. To map the internal port 80 to 8080, just do `-p 8080:80`, for example.

### Running King Haskell

The default entrypoint for this image is the C king; just change that through `--entrypoint ./urbit-king` to run the Haskell king.

### Mount to the local Filesystem

Just change the volume `urbit` into a local path. For example ``-v `pwd`/urbit:/opt/urbit``. **Don't do this** after running your ship with the default docker volume, as it'll be stateless once again.

### Change Ship Name

Only for the [Persistent Comets](#persistent-comets) section, just add `-c your-ship-name` after the image name.
