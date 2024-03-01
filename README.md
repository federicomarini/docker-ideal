# docker-ideal

# usage

Put your magic R object into the `./my_host_inputs/:/shiny_input` folder, it will be automagically picked up by the Shiny App in the container.
If the container is closed, which we recommend doing from the user interface, potential outputs are written into the `./my_host_outputs/`.

```bash
docker run -p 8080:3838 -v ./my_host_inputs/:/shiny_input -v ./my_host_outputs/:/shiny_output quay.io/federicomarini/ideal:v0.1 
```
