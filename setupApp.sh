#!/bin/sh

# defVersion=$(python -c 'import psychopy; print(psychopy.__version__)')
defVersion=$(<version)  # reads from the version file
echo "DID YOU UPDATE THE CHANGELOG?"
read -p "Version (def=$defVersion):" version
version=${version:-$defVersion}
echo "Building $version"

rm -r build
rm -r dist/PsychoPy*.app #the previous version
rm -r ../dist/PsychoPy*.app  # the previous version in outer location

python setup.py sdist --format=zip
# then handle the mac app bundle
rm psychopy/prefSite.cfg

declare -a pythons=("python3.6")
declare -a names=("PsychoPy")
declare -a todo=(0) # or  (1 0) to do both

for i in todo; do
    # mount the disk image and delete previous copy of app
#    echo "Opening disk image for app"
#    hdiutil detach "/Volumes/PsychoPy" -quiet
#    hdiutil attach "../dist/StandalonePsychoPy3_tmpl.dmg"
#    osascript -e "set Volume 0.2"
#    say -v Karen "password"
#    sudo rm -R /Volumes/PsychoPy/PsychoPy3*

    # remove old pyc files
    find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

    echo $i "BUILDING:" ${pythons[$i]} "__" ${names[$i]}
    dmgName="../dist/Standalone${names[$i]}-$version-MacOS.dmg"

    ${pythons[$i]} setupApp.py py2app || { echo 'setupApp.py failed' ; exit 1; }
    # copy over git-core folder
    cp -R -L /usr/local/git/libexec/git-core dist/${names[$i]}.app/Contents/Resources/git-core

    # remove matplotlib tests (45mb)
    rm -r dist/${names[$i]}.app/Contents/Resources/lib/python2.7/matplotlib/tests
    # strip all other architectures from binaries and move both to __fat copy
    mv dist/${names[$i]}.app dist/${names[$i]}__fat.app
    echo "stripping i386 using ditto"
    ditto --arch x86_64 dist/${names[$i]}__fat.app dist/${names[$i]}.app

    # built and stripped. Now mac codesign. Running in 2 steps to allow the detach step to work
    ${pythons[$i]} building/apple_sign.py --app "${names[$i]}.app" --runPostDmgBuild 0
    ${pythons[$i]} building/apple_sign.py --app "${names[$i]}.app" --runPreDmgBuild 0

    # mount the disk image and delete previous copy of app
#    echo "cp -R ${names[$i]}.app /Volumes/PsychoPy"
#    cp -R "${names[$i]}.app" "/Volumes/PsychoPy"
#    hdiutil detach "/Volumes/PsychoPy"
#    echo "removing prev dmg (although may not exist)"
#    rm $dmgName
#    echo "creating zlib-compressed dmg: $dmgName"
#    hdiutil convert "StandalonePsychoPy3_tmpl.dmg" -format UDZO -o $dmgName

    osascript -e "set Volume 0.2"
    say -v kate "Finished building for ${pythons[$i]}"
done

osascript -e "set Volume 0.2"
say -v Karen "all done"
osascript -e "set Volume 3"
