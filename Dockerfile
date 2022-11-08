# https://github.com/baxpr/fsl-base
# This base container has FSL and ImageMagick installed
FROM baxterprogers/fsl-base:v6.0.5.2

# Pipeline code
COPY README.md /opt/prept1/README.md
COPY src /opt/prept1/src
ENV PATH=/opt/prept1/src:${PATH}

# Entrypoint
ENTRYPOINT ["xwrapper.sh","prept1.sh"]
