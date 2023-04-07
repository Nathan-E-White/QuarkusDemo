#!/usr/bin/env bash

# Declare functions create_kotlin_app and create_java_app
declare -f create_kotlin_app;
declare -f create_java_app;

function create_kotlin_app() {

  # Stash args as local variables
  local directory_name="${1}";
  local group_id="${2}";
  local artifact_id="${3}";
  local version="${4}";

  echo "Creating project $project_name in $project_path"
  echo "Package name: $package_name"
  echo "Package path: $package_path"

  quarkus create                \
          -p "${package_name}"  \
          -a "${project_name}"  \
          -o "${project_path}"  \
          --gradle-kotlin-dsl   \
          --kotlin              \
          --code
}

function create_java_app() {

  local directory_name="${1}";
  local group_id="${2}";
  local artifact_id="${3}";
  local version="${4}";
  local package_name="${5}";

  # check if the chosen directory exists and delete it if it does exist
  if [ -d "${directory_name}" ]; then
    rm -rf "${directory_name}";
  fi

  # check if "code-with-quarkus" directory exists and delete it if it does
  if [ -d "code-with-quarkus" ]; then
    rm -rf "code-with-quarkus";
  fi

  echo "Creating project ${directory_name} in ${directory_name}";
  echo "Artifact: [[${group_id}:]${artifact_id}[:${version}]]";

  quarkus create                \
          -o "${directory_name}"  \
          --package-name "${package_name}"     \
          -DARTIFACT-ID="${artifact_id}"  \
          -DGROUP-ID="${group_id}"  \
          -DVERSION="${version}"  \
          -x="java"               \
          --maven               \
          --java=17 \
          --code
}



# Path: create-project.sh
# Usage: create-project.sh <project-name> <package-name> <project-path>
# Create a Quarkus project with the given name, package name and path
create_java_app "my-java-app" "com.dude.bro.chill.dev" "my-java-app" "1.0.0-SNAPSHOT" "app";
# create_kotlin_app "kotlin-app" "com.example" ".";




