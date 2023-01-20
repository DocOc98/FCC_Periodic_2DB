#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 == 1 || $1 == "H" || $1 == "Hydrogen" ]]
then
  echo "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
else
  ELEMENTS_RESULT=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1;")
  if [[ -z $ELEMENTS_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $ELEMENTS_RESULT #| read ATOMIC_NUMBER
  fi
fi