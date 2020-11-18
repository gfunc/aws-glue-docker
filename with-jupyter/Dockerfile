FROM webysther/aws-glue:spark-1.0-py3 as glue

RUN python -m pip install --user --upgrade pip && \
    python -m pip install --user jupyter
USER root:root    
RUN apt-get -q update -y && \
    apt-get -qq install -y procps

RUN mkdir /app/notebook &&\
    chown -R docker:docker /app && \
    echo "spark.hadoop.fs.s3a.endpoint s3.cn-northwest-1.amazonaws.com.cn" >> $SPARK_CONF_DIR/spark-defaults.conf

USER docker:docker
ENV JUPYTER_PORT=10089
COPY --chown=docker:docker glue-override.conf $SPARK_CONF_DIR/

CMD [ "jupyter","notebook","--no-browser", "--port=10089", "--ip=0.0.0.0", "--notebook-dir=./notebook" ]