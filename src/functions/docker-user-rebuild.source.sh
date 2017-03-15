#!/bin/bash
# @package exadra37-bash/dockerize-app
# @link    https://gitlab.com/u/exadra37-bash/dockerize-app
# @since   14 March 2017
# @license GPL-3.0
# @author  Exadra37(Paulo Silva) <exadra37ingmailpointcom>
#
# Social Links:
# @link    Auhthor:  https://exadra37.com
# @link    Gitlab:   https://gitlab.com/Exadra37
# @link    Github:   https://github.com/Exadra37
# @link    Linkedin: https://uk.linkedin.com/in/exadra37
# @link    Twitter:  https://twitter.com/Exadra37

set -e

########################################################################################################################
# Sourcing
########################################################################################################################

    ebda_functions_dir=$(cd "$( dirname "${BASH_SOURCE}" )" && pwd )

    source "${ebda_functions_dir}"/docker-user-build.source.sh


########################################################################################################################
# Functions
########################################################################################################################

    function Docker_User_Rebuild()
    {
        local _image_name="${1?}"

        local _image_tag="${2?}"

        local _build_context="${3?}"

        sudo docker rmi "${_image_name}:${_image_tag}"

        Docker_User_Build "${_image_name}" "${_image_tag}" "${_build_context}"
    }
