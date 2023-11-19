#!/bin/sh
#
# ---------------------------------------------------------------------
# PyCharm startup script.
# ---------------------------------------------------------------------
#

 message()
 {
   TITLE="Cannot start PyCharm"
   if [ -n "`which zenity`" ]; then
     zenity --error --title="$TITLE" --text="$1"
   elif [ -n "`which kdialog`" ]; then
     kdialog --error "$1" --title "$TITLE"
   elif [ -n "`which xmessage`" ]; then
     xmessage -center "ERROR: $TITLE: $1"
   elif [ -n "`which notify-send`" ]; then
     notify-send "ERROR: $TITLE: $1"
   else
     printf "ERROR: $TITLE\n$1\n"
   fi
}

PYCHARM_JDK=/usr/pkg/java/openjdk11
UNAME=`which uname`
GREP=`which egrep`
GREP_OPTIONS=""
CUT=`which cut`
READLINK=`which readlink`
XARGS=`which xargs`
DIRNAME=`which dirname`
MKTEMP=`which mktemp`
RM=`which rm`
CAT=`which cat`
SED=`which sed`

# if [ -z "$(command -v uname)" ] || [ -z "$(command -v realpath)" ] || [ -z "$(command -v dirname)" ] || [ -z "$(command -v cat)" ] || \
#    [ -z "$(command -v egrep)" ]; then
#   TOOLS_MSG="Required tools are missing:"
#   for tool in uname realpath egrep dirname cat ; do
#      test -z "$(command -v $tool)" && TOOLS_MSG="$TOOLS_MSG $tool"
#   done
#   message "$TOOLS_MSG (SHELL=$SHELL PATH=$PATH)"
#   exit 1
# fi
if [ -z "$UNAME" -o -z "$GREP" -o -z "$CUT" -o -z "$MKTEMP" -o -z "$RM" -o -z             "$CAT" -o -z "$SED" ]; then
message "Required tools are missing - check beginning of \"$0\" file for details."
exit 1
fi

OS_TYPE=`"$UNAME" -s`

# shellcheck disable=SC2034
GREP_OPTIONS=''
OS_ARCH=`"$UNAME" -m`

# ---------------------------------------------------------------------
# Ensure $IDE_HOME points to the directory where the IDE is installed.
# ---------------------------------------------------------------------

# IDE_BIN_HOME=`pwd`
# IDE_HOME=$(dirname "${IDE_BIN_HOME}")
# CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

SCRIPT_LOCATION=$0
if [ -x "$READLINK" ]; then
while [ -L "$SCRIPT_LOCATION" ]; do
SCRIPT_LOCATION=`"$READLINK" -e "$SCRIPT_LOCATION"`
done
fi

cd "`dirname "$SCRIPT_LOCATION"`"
IDE_BIN_HOME=`pwd`
IDE_HOME=`dirname "$IDE_BIN_HOME"`
cd "$OLDPWD"


# ---------------------------------------------------------------------
# Locate a JRE installation directory command -v will be used to run the IDE.
# Try (in order): $PYCHARM_JDK, .../pycharm.jdk, .../jbr, $JDK_HOME, $JAVA_HOME, "java" in $PATH.
# ---------------------------------------------------------------------
JRE=""

# shellcheck disable=SC2154
if [ -n "$PYCHARM_JDK" ] && [ -x "$PYCHARM_JDK/bin/java" ]; then
  JRE="$PYCHARM_JDK"
fi

BITS=""
if [ -z "$JRE" ] && [ -s "${CONFIG_HOME}/JetBrains/PyCharm2021.3/pycharm.jdk" ]; then
  USER_JRE=$(cat "${CONFIG_HOME}/JetBrains/PyCharm2021.3/pycharm.jdk")
  if [ -x "$USER_JRE/bin/java" ]; then
    JRE="$USER_JRE"
  fi
fi

if [ -z "$JRE" ] && [ "$OS_TYPE" = "Linux" ] && [ "$OS_ARCH" = "x86_64" ] && [ -d "$IDE_HOME/jbr" ]; then
  JRE="$IDE_HOME/jbr"
fi

# shellcheck disable=SC2153
if [ -z "$JRE" ]; then
  if [ -n "$JDK_HOME" ] && [ -x "$JDK_HOME/bin/java" ]; then
    JRE="$JDK_HOME"
  elif [ -n "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/java" ]; then
    JRE="$JAVA_HOME"
  fi
fi

if [ -z "$JRE" ]; then
  JAVA_BIN="$JDK/bin/java"
else
  JAVA_BIN="$JRE/bin/java"
fi

if [ -z "$JAVA_BIN" ] || [ ! -x "$JAVA_BIN" ]; then
  message "No JRE found. Please make sure \$PYCHARM_JDK, \$JDK_HOME, or \$JAVA_HOME point to valid JRE installation."
  exit 1
fi

# ---------------------------------------------------------------------
# Collect JVM options and IDE properties.
# ---------------------------------------------------------------------
# shellcheck disable=SC2154
if [ -n "$PYCHARM_PROPERTIES" ]; then
  IDE_PROPERTIES_PROPERTY="-Didea.properties.file=$PYCHARM_PROPERTIES"
fi

BITS="64"
VM_OPTIONS_FILE=""
USER_VM_OPTIONS_FILE=""
# shellcheck disable=SC2154
if [ -n "$PYCHARM_VM_OPTIONS" ] && [ -r "$PYCHARM_VM_OPTIONS" ]; then
  # 1. $<IDE_NAME>_VM_OPTIONS
  VM_OPTIONS_FILE="$PYCHARM_VM_OPTIONS"
else
  # 2. <IDE_HOME>/bin/[<os>/]<bin_name>.vmoptions ...
  if [ -r "${IDE_BIN_HOME}/pycharm${BITS}.vmoptions" ]; then
    VM_OPTIONS_FILE="${IDE_BIN_HOME}/pycharm${BITS}.vmoptions"
  else
    test "${OS_TYPE}" = "Darwin" && OS_SPECIFIC="mac" || OS_SPECIFIC="linux"
    if [ -r "${IDE_BIN_HOME}/${OS_SPECIFIC}/pycharm${BITS}.vmoptions" ]; then
      VM_OPTIONS_FILE="${IDE_BIN_HOME}/${OS_SPECIFIC}/pycharm${BITS}.vmoptions"
    fi
  fi
  # ... [+ <IDE_HOME>.vmoptions (Toolbox) || <config_directory>/<bin_name>.vmoptions]
  if [ -r "${IDE_HOME}.vmoptions" ]; then
    USER_VM_OPTIONS_FILE="${IDE_HOME}.vmoptions"
  elif [ -r "${CONFIG_HOME}/JetBrains/PyCharm2021.3/pycharm${BITS}.vmoptions" ]; then
    USER_VM_OPTIONS_FILE="${CONFIG_HOME}/JetBrains/PyCharm2021.3/pycharm${BITS}.vmoptions"
  fi
fi

VM_OPTIONS=""
USER_GC=""
if [ -n "$USER_VM_OPTIONS_FILE" ]; then
  egrep -q -e "-XX:\+.*GC" "$USER_VM_OPTIONS_FILE" && USER_GC="yes"
fi
if [ -n "$VM_OPTIONS_FILE" -o -n "$USER_VM_OPTIONS_FILE" ]; then
  if [ -z "$USER_GC" -o -z "$VM_OPTIONS_FILE" ]; then
    VM_OPTIONS=$(cat "$VM_OPTIONS_FILE" "$USER_VM_OPTIONS_FILE" 2> /dev/null | egrep -v -e "^#.*")
  else
    VM_OPTIONS=$({ egrep -v -e "-XX:\+Use.*GC" "$VM_OPTIONS_FILE"; cat "$USER_VM_OPTIONS_FILE"; } 2> /dev/null | egrep -v -e "^#.*")
  fi
else
  message "Cannot find a VM options file"
fi

CLASSPATH="$IDE_HOME/lib/util.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/bootstrap.jar"
# shellcheck disable=SC2154
if [ -n "$PYCHARM_CLASSPATH" ]; then
  CLASSPATH="$CLASSPATH:$PYCHARM_CLASSPATH"
fi

# ---------------------------------------------------------------------
# Run the IDE.
# ---------------------------------------------------------------------
IFS="$(printf '\n\t')"
# shellcheck disable=SC2086
"$JAVA_BIN" \
  -classpath "$CLASSPATH" \
  ${VM_OPTIONS} \
  "-XX:ErrorFile=$HOME/java_error_in_pycharm_%p.log" \
  "-XX:HeapDumpPath=$HOME/java_error_in_pycharm_.hprof" \
  "-Djb.vmOptionsFile=${USER_VM_OPTIONS_FILE:-${VM_OPTIONS_FILE}}" \
  ${IDE_PROPERTIES_PROPERTY} \
  -Djava.system.class.loader=com.intellij.util.lang.PathClassLoader -Didea.vendor.name=JetBrains -Didea.paths.selector=PyCharm2021.3 -Didea.platform.prefix=Python -Dsplash=true \
  com.intellij.idea.Main \
  "$@"
