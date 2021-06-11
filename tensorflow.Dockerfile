#use the latest version of Tensorflow.

FROM tensorflow/tensorflow:latest
WORKDIR /root

# Install your deps
RUN pip install ...

# Installs google cloud sdk, this is mostly for using gsutil to    
# export the model.
RUN wget -nv \
    https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz && \
    mkdir /root/tools && \
    tar xvzf google-cloud-sdk.tar.gz -C /root/tools && \
    rm google-cloud-sdk.tar.gz && \
    /root/tools/google-cloud-sdk/install.sh --usage-reporting=false \
    --path-update=false --bash-completion=false \
    --disable-installation-options && \
    rm -rf /root/.config/* && \
    ln -s /root/.config /config && \
    # Remove the backup directory that gcloud creates
    rm -rf /root/tools/google-cloud-sdk/.install/.backup

# Path configuration
ENV PATH $PATH:/root/tools/google-cloud-sdk/bin

# Make sure gsutil will use the default service account
RUN echo '[GoogleCompute]\nservice_account = default' > /etc/boto.cfg


# Do your thing here to set up your code
#
#

# Change the below to your exec. Make sure you chmod +x the script first
ENTRYPOINT ["sh", "your_dir/script.sh"]