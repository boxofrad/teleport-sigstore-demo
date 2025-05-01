# tctl auth export --type tls-spiffe
spiffe_ca_bundle = "-----BEGIN CERTIFICATE-----\nMIICBTCCAaugAwIBAgIRAPrD4VRe/IbtyU4d0Zzo0OcwCgYIKoZIzj0EAwIwYjEW\nMBQGA1UEChMNdHAxLmZsb3BweS5jbzEWMBQGA1UEAxMNdHAxLmZsb3BweS5jbzEw\nMC4GA1UEBRMnMzMzMzI0MDY3MDYwMzY2NjA5ODUwODA2ODk1MDkzMjE3ODA4NjE1\nMB4XDTI1MDMwNzEwNDQwOVoXDTM1MDMwNTEwNDQwOVowYjEWMBQGA1UEChMNdHAx\nLmZsb3BweS5jbzEWMBQGA1UEAxMNdHAxLmZsb3BweS5jbzEwMC4GA1UEBRMnMzMz\nMzI0MDY3MDYwMzY2NjA5ODUwODA2ODk1MDkzMjE3ODA4NjE1MFkwEwYHKoZIzj0C\nAQYIKoZIzj0DAQcDQgAENWr+VGf16MUmHz8G86tgna+2w+RIeTwISiOttIGhIeID\n1/ko8H/RwBj+wlppdBqenTLGzrGpyoCpzqp7QTTh6KNCMEAwDgYDVR0PAQH/BAQD\nAgGGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFBmfdcwh3LFATKWU/H+XwVW8\ntAp4MAoGCCqGSM49BAMCA0gAMEUCIQCZ0mGQCf2kkrViIq/LgYrrX3rGhgOCK0k5\nzZVvK7LNagIge/OpDUMVMtiTAsMYMYrOsJlMfQ9f8OHaPitCTyzNIjo=\n-----END CERTIFICATE-----\n"

spiffe_san_matcher = "spiffe://tp1.floppy.co/k8s/*"

trust_anchor_name = "boxofrad-spiffe"
profile_name      = "boxofrad-spiffe-laptop"
role_name         = "boxofrad-spiffe-rolesanywhere"
s3_bucket         = "boxofrad-bucket"
