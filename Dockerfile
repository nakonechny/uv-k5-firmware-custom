# syntax=docker/dockerfile:1.6

# Default platform for Arch (useful on Mac Silicon)
ARG ARCH_PLATFORM=linux/amd64

########################
# Stage: Arch toolchain
########################
FROM --platform=${ARCH_PLATFORM} archlinux:latest AS toolchain-arch
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
      base-devel \
      arm-none-eabi-gcc \
      arm-none-eabi-newlib \
      git \
      python-pip \
      python-crcmod
WORKDIR /app
COPY . .

#########################
# Stage: Alpine toolchain
#########################
FROM alpine:3.22 AS toolchain-alpine
RUN apk add --no-cache \
      bash \
      build-base \
      gcc-arm-none-eabi \
      newlib-arm-none-eabi \
      python3 \
      py3-crcmod \
      py3-pip \
      git
WORKDIR /app
COPY . .
