#!/bin/bash
# @package exadra37-bash/dockerize-app
# @link    https://gitlab.com/u/exadra37-bash/dockerize-app
# @since   2017/03/09
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
    source "${ebda_functions_dir}"/../../vendor/exadra37-bash/pretty-print/src/functions/raw-color-print.source.sh
    source "${ebda_functions_dir}"/../../vendor/exadra37-bash/x11-server/src/functions/x11-server-authority.source.sh
    source "${ebda_functions_dir}"/../../vendor/exadra37-bash/docker-validator/src/functions/validate-images.source.sh


########################################################################################################################
# Functions
########################################################################################################################

    function Docker_Run()
    {
        ### VARIABLES DEFAULTS ###

            # location to current x11 server socket in our machine
            local _x11_socket=/tmp/.X11-unix

            local _container_user="${USER}"


        ### VARIABLES ARGUMENTS ###

            local _image_name="${1?}"

            local _image_tag="${2?}"

            local _build_context="${3?}"

            local _cli_name="${4?}"

            local _volumes="${5}"

            local _command="${6}"

            local _arguments="${7}"


        ### VARIABLES COMPOSITION ###

            local _timestamp=$( date +"%s" )

            # from word vendor-name/image-name we will get just the image-name plus the time stamp
            local _container_name="${_image_name##*/}_${_timestamp}"

            # temporary x11 authority file to allow the docker container to talk with the x11 server in our machhine
            local _x11_authority_file=/tmp/.dockerize-app/"${_container_name}"/x11-authority


        ### VALIDATIONS ###

            if Docker_Image_Does_Not_Exist "${_image_name}"
                then
                    Docker_User_Build "${_image_name}" "${_image_tag}" "${_build_context}"
            fi


        ### EXECUTION ###

            Print_Text_With_Label "Shell Into Container" "${_cli_name} shell ${_container_name}"

            Print_Text "Setup X11 Server Authority..." 37 # light grey

            # Run Container with X11 authentication and using same user in container and host
            # @link http://wiki.ros.org/docker/Tutorials/GUI#The_isolated_way
            #
            # _x11_socket and _x11_authority_file only have ready access to the Host, instead of ready and write.
            Setup_X11_Server_Authority "${_x11_authority_file}"

            sudo docker run \
                    --rm \
                    --tty \
                    --interactive \
                    --env="XAUTHORITY=${_x11_authority_file}" \
                    --env="DISPLAY" \
                    --user="${_container_user}" \
                    --name="${_container_name}" \
                    --volume="${_x11_socket}":"${_x11_socket}":ro \
                    --volume="${_x11_authority_file}":"${_x11_authority_file}":ro \
                    ${_volumes} \
                    "${_image_name}" \
                    "${_command}" ${_arguments}

            rm -rf "${_x11_authority_file}"
    }
