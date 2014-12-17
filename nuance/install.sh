#!/bin/sh
#
#    File:        install.sh
#    Author:      Nuance Communications, Inc.
#
#    Description: Nuance Recognizer 9.0 Installation Script
#
#


# -----------------------------------------------------
# Sub Routines
# -----------------------------------------------------

# -----------------------------------------------------
# Define the required environment
# -----------------------------------------------------

defineEnv() {

    DEBUG="ON"

    PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
    export PATH

    APPLICATION="NRec"
    APPLICATION_VERSION="9.0"
    APPLICATION_RPM="NRec-$APPLICATION_VERSION"
    INSTALL_DIR="/usr/local"
    PRODUCT_DIR="/Nuance/Recognizer"
    PRODUCT_NAME="Nuance Recognizer"

    BASE_INSTALL="n"
    OLD_UPGRADE="n"
    UNATTENDED_INSTALL="n"
    UPGRADE_INSTALL="n"

    COPYRIGHT_YEAR=`date +%Y`

    if [ "$1" = "default" ]; then
        UNATTENDED_INSTALL="y"
    fi
}



# -----------------------------------------------------
# Check whether the current user is the root user
# -----------------------------------------------------

checkUser() {
    WHOAMI=`whoami`
    if [ "$WHOAMI" != "root" ]; then
        echo ""
        echo ""
        echo "You must install the $PRODUCT_NAME as the root user."
        echo ""
        echo ""
        exit 1
    fi
}



# -----------------------------------------------------
# Check for the presence of conflicting products
# -----------------------------------------------------

checkProductConflicts() {
    rpm -q nvp-base > /dev/null 2>&1
    if [ "$?" = "0" ]; then
        echo ""
        echo ""
        echo "The Nuance Voice Platform and the Nuance Recognizer cannot"
        echo "be installed on the same machine.  To install the Nuance"
        echo "Recognizer, you must uninstall the Nuance Voice Platform."
        echo ""
        echo ""
        exit 1
    fi
}



# -----------------------------------------------------
# Check whether the new RPM exists and derive version
# -----------------------------------------------------

checkNewRPM() {
    RPMS_TO_INSTALL=""
    for i in $APPLICATION_RPM; do
        RPMFOUND=`ls $i*.rpm | tail -1`
        if [ ! -z "$RPMFOUND" ]; then
            RPMS_TO_INSTALL="$RPMFOUND"
        else
            echo ""
            echo ""
            echo "The $PRODUCT_NAME rpm is file missing in the current directory."
            echo ""
            echo "Please check the directory where you extracted the downloaded"
            echo "archive for this rpm."
            echo ""
            echo ""
            exit 1
        fi
    done

    NEWMAJ_VER=`ls $APPLICATION_RPM*rpm | tail -1 | cut -d'-' -f2 | cut -d'.' -f1`
    NEWMIN_VER=`ls $APPLICATION_RPM*rpm | tail -1 | cut -d'-' -f2 | cut -d'.' -f2`
    NEWSP_VER=`ls $APPLICATION_RPM*rpm | tail -1 | cut -d'-' -f3 | cut -d'.' -f1`
    NEWRELEASE_NUM=$NEWMAJ_VER$NEWMIN_VER$NEWSP_VER
    NEWRELEASE_STR=$NEWMAJ_VER.$NEWMIN_VER-$NEWSP_VER
}



# -----------------------------------------------------
# Check whether some version of the product already exists
# -----------------------------------------------------

checkForExistingInstall() {

    CV=`rpm -q $APPLICATION --queryformat '%{VERSION}'`
    if [ "$?" = "0" ]; then
        CURRENTVER="$CV"
    fi

    if [ -n "$CURRENTVER" ]; then
        CSP=`rpm -q $APPLICATION --queryformat '%{RELEASE}'`

        if [ "$CSP" = "0" ] || [ "$CSP" = "1" ]; then
        	OLD_UPGRADE="y"
        fi

        CURRENTMAJ_VER=`echo $CURRENTVER | cut -d'.' -f1`
        CURRENTMIN_VER=`echo $CURRENTVER | cut -d'.' -f2`
        CURRENTRELEASE_NUM=$CURRENTMAJ_VER$CURRENTMIN_VER$CSP
        CURRENTRELEASE_STR=$CURRENTMAJ_VER.$CURRENTMIN_VER-$CSP

        if [ $NEWMAJ_VER -gt $CURRENTMAJ_VER ]; then
            UPGRADE_INSTALL="y"

        elif [ $NEWMAJ_VER -lt $CURRENTMAJ_VER ]; then
            echo ""
            echo ""
            echo "This version of $PRODUCT_NAME is less recent than the $CURRENTRELEASE_STR version"
            echo "already installed."
            echo ""
            echo ""
            exit 1

        elif [ $NEWRELEASE_NUM -gt $CURRENTRELEASE_NUM ]; then
            UPGRADE_INSTALL="y"

        elif [ $NEWRELEASE_NUM -eq $CURRENTRELEASE_NUM ]; then
            echo ""
            echo ""
            echo "$PRODUCT_NAME $CURRENTRELEASE_STR is already installed."
            echo ""
            echo ""
            exit 1

        elif [ $NEWRELEASE_NUM -lt $CURRENTRELEASE_NUM ]; then
            echo ""
            echo ""
            echo "This version of $PRODUCT_NAME is less recent than the $CURRENTRELEASE_STR version"
            echo "already installed."
            echo ""
            echo ""
            exit 1

        else
            BASE_INSTALL="y"
        fi
    else
        BASE_INSTALL="y"
    fi
}


# -----------------------------------------------------
# Install the product
# -----------------------------------------------------

installProduct() {
    echo " "
    echo "Copyright � $COPYRIGHT_YEAR, Nuance Communications, Inc.  All rights reserved."
    echo " "
    echo ""
    echo "Welcome to the $PRODUCT_NAME $NEWRELEASE_STR Installation."
    echo ""

    if [ "$UPGRADE_INSTALL" = "y" ]; then
        if [ "$UNATTENDED_INSTALL" = "n" ]; then
            upgradeYesOrNo
            if [ "$ANSWER" = "n" ]; then
                echo ""
                echo ""
                echo "Upgrade installation has been canceled."
                echo ""
                echo ""
                exit 1
            fi
         fi

        INSTALL_DIR=`rpm -q $APPLICATION --queryformat '%{INSTPREFIXES}'`

		if [ "$OLD_UPGRADE" = "y" ]; then
			# Remove the old product version to prevent upgrade issues
	        rpm -e $APPLICATION_RPM-$CSP

	        if [ "$?" != "0" ]; then
	            echo ""
	            echo ""
	            echo "$PRODUCT_NAME $CURRENTRELEASE_STR was not successfully removed!"
	            echo ""
	            echo "Stopping the upgrade operation."
	            echo ""
	            echo ""
	            exit 1
	        fi
	    fi
    else
        echo ""
        echo "The product will be installed in a $PRODUCT_DIR product directory"
        echo "in the $INSTALL_DIR default parent directory."
        echo ""
        if [ "$UNATTENDED_INSTALL" = "n" ]; then
            checkParentInstallPath
            INSTALL_DIR="$ANSWER"
        fi
    fi


    echo ""
    echo "Installing $PRODUCT_NAME $NEWRELEASE_STR"
    echo ""

    # Install or upgrade NuanceVersion
    installNuanceVersion

    if [ "$DEBUG" = "ON" ]; then
        RPM_OPT="--nodeps"
    else
        RPM_OPT=" "
    fi

    rpm -Uvh --prefix "$INSTALL_DIR" $RPMS_TO_INSTALL $RPM_OPT

    if [ "$?" == "0" ]; then
        echo ""
        echo ""
        echo "$PRODUCT_NAME $NEWRELEASE_STR was successfully installed to"
        echo "$INSTALL_DIR/Nuance/Recognizer."
        echo ""
        echo ""
        echo ""
        echo "Visit the Nuance Network Customer Service Portal (http://network.nuance.com)"
        echo "for updates and the latest release notes."
        echo ""
        echo ""
    else
        echo ""
        echo ""
        echo "$PRODUCT_NAME $NEWRELEASE_STR was not successfully installed!"
        echo ""
        echo ""
    fi
}



# -----------------------------------------------------
# Check for a yes or no response
# -----------------------------------------------------

checkYesOrNo() {
    if [ $# = "1" ]; then
        QUESTION="$1 [y,n]"
    else
        QUESTION="Yes or no? [y,n]"
    fi

    ANSWER=x
    while [ "$ANSWER" == "x" ]; do
        echo ""
        echo "$QUESTION"
        read ans
        if [ "$ans" == "y" ] || [ "$ans" == "Y" ]; then
            ANSWER=y
        elif [ "$ans" == "n" ] || [ "$ans" == "N" ]; then
            ANSWER=n
        fi
    done
}



# -----------------------------------------------------
# Check for a yes or no response for upgrading
# -----------------------------------------------------

upgradeYesOrNo() {

    echo "Do you want to upgrade the $PRODUCT_NAME from"
    echo "$APPLICATION-$CURRENTRELEASE_STR to $APPLICATION_RPM-$NEWSP_VER? [y,n]"

    ANSWER=x
    while [ "$ANSWER" == "x" ]; do
        read ans
        if [ "$ans" == "y" ] || [ "$ans" == "Y" ]; then
            ANSWER=y
        elif [ "$ans" == "n" ] || [ "$ans" == "N" ]; then
            ANSWER=n
        fi
    done
}



# -----------------------------------------------------
# Determine the parent directory for the installation
# -----------------------------------------------------

checkParentInstallPath() {
    ANSWER=x
    while [ "$ANSWER" == "x" ]; do
        echo "To specify a different directory, type an absolute"
        echo "path below and press the [Enter] key."
        echo ""
        echo "To accept the default parent directory of $INSTALL_DIR,"
        echo "press the [Enter] key."
        echo ""
        read ans
        if [ -z "$ans" ]; then
            ans="$INSTALL_DIR"
        else
            ans=`echo $ans | sed '/^\/[0-9a-zA-Z/_\-\.]*$/!d'`
        fi

        if [ "$ans" == "/" ]; then
            echo "$ans is not permitted! Please choose another path."
            ans=""
        elif [ ! -z "$ans" ]; then
            ANSWER="$ans"
        else
            echo ""
            echo "That is not a valid absolute path!"
            echo ""
        fi
    done
}



# -----------------------------------------------------
# Install or Upgrade Nuance Version
# -----------------------------------------------------

installNuanceVersion() {

    # Determine if Nuance Version is installed
    echo "Checking if NuanceVersion is installed..."
    rpm -q NuanceVersion > /dev/null 2>&1
    if [ "$?" != "0" ]; then
        # Nuance Version is not installed.
        # Install it to the default location of /usr/local
        echo "Not installed. Installing..."
        rpm -U NuanceVersion-*.rpm --prefix "$INSTALL_DIR"
    else
        # A release of Nuance Version is installed.
        # Test to determine whether Nuance Version can
        # be upgraded with the release in this package
        rpm -U --test NuanceVersion-*.rpm > /dev/null 2>&1
        if [ "$?" = "0" ]; then
            # An upgrade of Nuance Version is possible.
            # Get the installed location of Nuance Version
            NV_PREFIX=`rpm -q NuanceVersion --queryformat '%{INSTPREFIXES}'`

            # Upgrade Nuance Version in its installed location
            rpm -U --prefix $NV_PREFIX NuanceVersion-*.rpm
        fi
    fi
}



# -----------------------------------------------------
# Main Routine
# -----------------------------------------------------

defineEnv $1

checkUser

checkProductConflicts

checkNewRPM

checkForExistingInstall

installProduct

exit 0
