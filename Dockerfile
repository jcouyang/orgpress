FROM alpine:latest
RUN apk add emacs git openssh
WORKDIR /orgpress
COPY orgpress.setup.el .
RUN emacs -batch -l orgpress.setup.el
COPY orgpress.el .
WORKDIR /blog
CMD emacs -batch -l /orgpress/orgpress.el -f org-publish-all
