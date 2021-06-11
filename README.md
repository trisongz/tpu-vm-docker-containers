# Accessing TPUs in Docker Containers with TPU VM
 Docker File Templates to access TPUs within TPU VM in Containers

This Github repo accompanies the [Medium Post](https://trisongz.medium.com/accessing-your-tpus-in-docker-containers-with-tpu-vm-e944f5909dd4) about how to get your containers to access the TPU directly in TPU VMs

## The Important Pieces

Below is the most important configs in the docker-compose.yaml file that you'll need to include in your specific container that is accessing the TPU. 

```yaml
cap_add:
    - ALL #unsure if necessary
environment:
    - TPU_NAME=tpu_name
    - TF_CPP_MIN_LOG_LEVEL=0
    - XRT_TPU_CONFIG="localservice;0;localhost:51011"
    - TF_XLA_FLAGS=--tf_xla_enable_xla_devices
volumes:
    - /var/run/docker.sock:/var/run/docker.sock #unsure if necessary
    - /usr/share/tpu/:/usr/share/tpu/
    - /lib/libtpu.so:/lib/libtpu.so
privileged: true
devices:
    - "/dev:/dev"
```

Included are a few Dockerfiles to help make sure google-cloud-sdk are installed with the service account that TPU VM is configured with.

After configuring your Dockerfile, docker-compose and tpu.env, you should be able to run

```bash
docker-compose -f docker-compose.yaml --env-file=tpu.env up # -d for daemon
```

If you this repository helpful, I'd appreciate a star, a fork, or even sharing it!