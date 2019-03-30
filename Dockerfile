FROM alpine:latest
RUN apk add emacs git openssh
WORKDIR /orgpress
COPY orgpress.setup.el .
COPY orgpress.el .
RUN emacs -batch -l orgpress.setup.el
CMD emacs -batch -l orgpress.el -f org-publish-all
