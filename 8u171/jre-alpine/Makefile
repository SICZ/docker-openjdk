### BASE_IMAGE #################################################################

BASE_IMAGE_OS		?= alpine
BASE_IMAGE_NAME		?= $(DOCKER_PROJECT)/baseimage-$(BASE_IMAGE_OS)
BASE_IMAGE_TAG		?= $(ALPINE_VERSION)

### DOCKER_IMAGE ###############################################################

OPENJDK_EDITION		?= jre
OPENJDK_EDITION_DESC	?= Java Runtime Environment

### MK_DOCKER_IMAGE ############################################################

PROJECT_DIR		?= $(abspath ../..)
include ../docker.openjdk.mk

################################################################################
