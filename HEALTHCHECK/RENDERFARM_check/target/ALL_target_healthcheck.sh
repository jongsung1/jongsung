#!/bin/bash

DIR=/idea_backup/script/HEALTHCHECK/RENDERFARM_check/target

${DIR}/CACHE_healthcheck.sh
${DIR}/DPX_healthcheck.sh
${DIR}/ENV_healthcheck.sh
${DIR}/FARM_healthcheck.sh
${DIR}/HPFX_healthcheck.sh
${DIR}/HPRENDER_healthcheck.sh
