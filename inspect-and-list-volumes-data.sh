#!/bin/bash 

# Must be run as sudo, since the data are in /var/lib
if [[ $(id -u) -ne 0 ]]
  then echo "Please run as root. Although the volume listing is also possible for non sudo-users, the inspection of the persisted data on the filesystem requires root priviledges"
  exit
fi

mapfile -d "\n" VOLUMES< <(docker volume ls --format "{{.Name}}")

OUTPUT_FILE="volume_inspection.log"
touch $OUTPUT_FILE

for volumeName in $VOLUMES; do
  
  CREATED_AT=$( docker volume inspect "${volumeName}" | jq '.[0].CreatedAt')
  NAME=$( docker volume inspect "${volumeName}" | jq '.[0].Name')
  LABELS=$( docker volume inspect "${volumeName}" | jq '.[0].Labels')
  MOUNTPOINT=$( docker volume inspect "${volumeName}" | jq '.[0].Mountpoint' | sed -r "s/\\\"//g")
  CONTENT=$(ls -Alh "${MOUNTPOINT}")

  { echo "Created at : $CREATED_AT"; echo "Volume name: $NAME"; echo "Volume Labels: $LABELS"; echo "Volume MountPoint: $MOUNTPOINT"; echo "Content: $CONTENT"; } >> $OUTPUT_FILE
  echo "############################################################################" >> $OUTPUT_FILE
    
done

# Change permissions
chown 1000:1000 "${OUTPUT_FILE}"
chmod 666 "${OUTPUT_FILE}"
