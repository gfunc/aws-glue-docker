FROM webysther/aws-glue:spark-py3 as glue
FROM apache/zeppelin:0.8.2 as zeppelin



COPY --from=glue /zeppelin /opt/zeppelin

ENV Z_HOME="/opt/zeppelin" \
    LOG_TAG="[ZEPPELIN:0.8.2]:"

USER root:root

# should install conda first before numpy, matploylib since pip and python will be installed by conda
RUN echo "$LOG_TAG Install miniconda3 related packages" && \
    apt-get -y update && \
    apt-get install -y bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN echo "$LOG_TAG Install python related packages" && \
    apt-get -y update && \
    apt-get install -y python-dev python-pip && \
    apt-get install -y gfortran && \
    # numerical/algebra packages
    apt-get install -y libblas-dev libatlas-base-dev liblapack-dev && \
    # font, image
    apt-get install -y libpng-dev libfreetype6-dev libxft-dev && \
    # for tkinter
    apt-get install -y python-tk libxml2-dev libxslt-dev zlib1g-dev && \
    hash -r && \
    conda config --set always_yes yes --set changeps1 no && \
    conda update -q conda && \
    conda info -a && \
    conda config --add channels conda-forge && \
    pip install -q pycodestyle==2.5.0 && \
    pip install -q numpy==1.17.3 pandas==0.25.0 scipy==1.3.1 grpcio==1.19.0 bkzep==0.6.1 hvplot==0.5.2 protobuf==3.10.0 pandasql==0.7.3 ipython==7.8.0 matplotlib==3.0.3 ipykernel==5.1.2 jupyter_client==5.3.4 bokeh==1.3.4 panel==0.6.0 holoviews==1.12.3 pycodestyle==2.5.0 apache_beam==2.15.0
# Install kubectl
RUN apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

RUN echo "$LOG_TAG Cleanup" && \
    apt-get autoclean && \
    apt-get clean

RUN chown -R root:root ${Z_HOME} && \
    mkdir -p ${Z_HOME}/logs ${Z_HOME}/run ${Z_HOME}/webapps && \
    chmod -R 775 "${Z_HOME}/logs" "${Z_HOME}/run" "${Z_HOME}/notebook" "${Z_HOME}/conf" && \
    chmod 775 ${Z_HOME}

ENV ZEPPELIN_PORT=9090 \
    ZEPPELIN_ADDR="0.0.0.0" \
    ZEPPELIN_INTP_CLASSPATH_OVERRIDES="${Z_HOME}/conf/"
EXPOSE ${ZEPPELIN_PORT}

WORKDIR ${Z_HOME}


# setup configurations
RUN echo "spark.hadoop.fs.s3a.endpoint s3.cn-northwest-1.amazonaws.com.cn" >> $SPARK_CONF_DIR/spark-defaults.conf &&\
    echo "export SPARK_HOME=${SPARK_HOME}" > ${Z_HOME}/conf/zeppelin-env.sh

COPY glue-override.conf conf/glue-override.conf
COPY init.sh init.sh
CMD ["bin/zeppelin.sh"]