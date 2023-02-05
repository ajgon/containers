#Spec: {
	app:  #NonEmptyString
	base: bool
	daemon: bool
	channels: [...#Channels]
}

#Channels: {
	name: #NonEmptyString
  "renovate::dataSource"?: string
  "renovate::depName"?: string
  "renovate::versioning"?: string
	version: =~ "^([0-9]+.){1,2}[0-9]+(-.+)?$"
	platforms: [...#AcceptedPlatforms]
}

#NonEmptyString:           string & !=""
#AcceptedPlatforms:        "linux/amd64" | "linux/arm64"
