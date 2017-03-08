#!/bin/bash
# @package exadra37-bash/dockerize-app
# @link    https://gitlab.com/u/exadra37-bash/dockerize-app
# @since   2017/03/08
# @license MIT
# @author  Exadra37(Paulo Silva) <exadra37ingmailpointcom>
#
# Social Links:
# @link    Auhthor:  https://exadra37.com
# @link    Github:   https://gitlab.com/Exadra37
# @link    Github:   https://github.com/Exadra37
# @link    Linkedin: https://uk.linkedin.com/in/exadra37
# @link    Twitter:  https://twitter.com/Exadra37


########################################################################################################################
# Functions
########################################################################################################################

    function build()
    {
        local docker_image_name="${1}"

        local build_context="${2}"

        local uid=$( id -u )

        local gid=$( id -g )

        sudo docker build \
                --build-arg HOST_USER="${USER}" \
                --build-arg HOST_UID="${uid}" \
                --build-arg HOST_GID="${gid}" \
                -t "${docker_image_name}" \
                "${build_context}"
    }
