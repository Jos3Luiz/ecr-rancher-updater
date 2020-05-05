from python:3.7-alpine
COPY ./src/kubectl /usr/local/bin/kubectl
COPY ./src/rancher /usr/local/bin/rancher
RUN apk -Uuv add groff less python py-pip
RUN python -m pip install awscli
COPY ./src/create.sh ./
RUN mkdir ~/.aws/ 

ENV AWS_ACCESS_KEY_ID=key_id
ENV AWS_SECRET_ACCESS_KEY=secret_key
ENV CONTEXT_PROJECT=rancher_project_context
ENV RANCHER_TOKEN=token-rancher_token_here
ENV NAMESPACE=valid_namespace
ENV RANCHER_ENDPOINT=endpoint_url
ENV DOCKER_SERVER_URL=ecr_url

ENTRYPOINT ["/bin/sh"]
CMD ["./create.sh"]
