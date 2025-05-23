#!/usr/bin/python

import sys
import os
import shutil

import argparse
import tarfile

parser = argparse.ArgumentParser(description="Extracts tar programs inside of a dir into /opt dir and creates symlinks inside of $HOME/bin")

parser.add_argument("--archives", '-a', action="extend", help="a list of archives to extract and creates a symlink", type=str, nargs='+')
parser.add_argument("--dirs", '-d', action="extend", help="a list of directories to extract all archives from and creates symlink", type=str, nargs='+')

args = parser.parse_args()
arguments = vars(args)

archives = arguments['archives']
directories = arguments['dirs']

if archives is None and directories is None:
    raise RuntimeError("must specify at least one archive or one directory")


def move_folder(extractDir: str, topLevelDir: str, folderPath: str):
    homeApps = None
    if os.path.isdir(folderPath):
        if (os.path.isdir(os.path.join(extractDir, topLevelDir))):
            print("found existing directory at %s" %
                  os.path.join(extractDir, topLevelDir))
            answer = input("Remove ? y/n ")
            if answer in ['y', 'Y', 'Yes', 'yes']:
                print("removing ...")
                shutil.rmtree(os.path.join(extractDir, topLevelDir))
            else:
                return 1
        try:
            print("trying to move %s to /opt" % folderPath)
            shutil.move(folderPath, "/opt/")
        except PermissionError:
            print("permission denied ...")
            homeApps = os.path.join(os.getenv("HOME"), "Applications")
            print("trying %s instead" % homeApps)
            if not os.path.isdir(homeApps):
                os.mkdir(os.path.join(os.getenv("HOME"), "Applications"))
                extractDir = homeApps
            shutil.move(folderPath, homeApps)
            print("Dirs: ")
            print(homeApps, extractDir, topLevelDir)
        finally:
            if homeApps is None:
                create_symlink(extractDir, topLevelDir)
            else:
                create_symlink(homeApps, topLevelDir)
    return 0


def create_symlink(extractDir: str, topLevelDir: str):
    for root, _, files in os.walk(os.path.join(extractDir, topLevelDir)):
        for f in files:
            sourceDir = os.path.join(root, f)
            if not os.access(sourceDir, os.X_OK):
                continue

            import re
            match = os.path.splitext(f)[0]
            extension = os.path.splitext(f)[1]

            if re.search(match, topLevelDir) or topLevelDir.lower().find(match, 0, len(topLevelDir)) != -1:
                destDir = os.path.join(os.getenv('HOME'), "bin", match)
                if extension in ['.sh', '']:
                    if os.path.isfile(destDir):
                        os.remove(destDir)
                    print("found the %s executable that matches folder name" % sourceDir)
                    os.symlink(sourceDir, destDir)
                    break


def extract_tar(tarFile):
    print("extracting %s file" % tarFile)
    tar = tarfile.open(os.path.abspath(tarFile))
    topLevelDir = os.path.commonprefix(tar.getnames())
    tar.extractall("/tmp/")
    tar.close()

    folderPath = os.path.join("/tmp/", topLevelDir)

    if(move_folder("/opt", topLevelDir, folderPath)):
        shutil.rmtree(folderPath)


if archives is not None:
    for i in archives:
        if not tarfile.is_tarfile(i):
            raise TypeError("%s is not a valid tar file, exiting ..." % i)
        extract_tar(i)


if directories is not None:
    for i in directories:
        if not os.path.isdir(i):
            raise TypeError("%s is not a valid directory, exitting ..." % i)
        for root, dirs, files in os.walk(os.path.abspath(i)):
            for f in files:
                fileName = os.path.join(root, f)
                if tarfile.is_tarfile(fileName):
                    extract_tar(fileName)
