#!/bin/bash
# @package exadra37-bash/dockerize-app
# @link    https://gitlab.com/u/exadra37-bash/dockerize-app
# @since   2017/03/10
# @license GPL-3.0
# @author  Exadra37(Paulo Silva) <exadra37ingmailpointcom>
#
# Social Links:
# @link    Auhthor:  https://exadra37.com
# @link    Github:   https://gitlab.com/Exadra37
# @link    Github:   https://github.com/Exadra37
# @link    Linkedin: https://uk.linkedin.com/in/exadra37
# @link    Twitter:  https://twitter.com/Exadra37

set -e

########################################################################################################################
# Sourcing
########################################################################################################################

    ebda_functions_dir=$(cd "$( dirname "${BASH_SOURCE}" )" && pwd )

    source "${ebda_functions_dir}"/docker-build.source.sh


########################################################################################################################
# Functions
########################################################################################################################

    function Docker_Rebuild()
    {
        local _image_name="${1?}"

        local _build_context="${2?}"

        sudo docker rmi "${_image_name}"

        Docker_Build "${_image_name}" "${_build_context}"
    }
