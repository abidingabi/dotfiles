{ ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users.users.abi.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCr/IuPgb6qrzlt+Rjp/Tnoz3gUsYnQQ6GYEeW4NRgEnpDdjXKXupGPrk97cbSgkRPWxCvJtreMZuKBFdkmxPX43yxCXn/wEPo2/FV/9/ymYnysuYePB8qLqvNE9hMAbajJSjJB8KYhPT++w9GkXYAyGulueisQ0RXpruzkVWoqbLepCRZUYNrE+ik+xQPx5vSPfq5ZfMZyPajWGhG8WIm3mc54zC+5r4VoGQaKlMavh/l1RHoxoUHywI1anR373mNJdsgXFNZ485kKu2U/St8g2yBb5MHEk9CVxu35tRqsFolxUYdX/4oCzu/hxX9Ex329eiuZrg0e5Aoafh/7eMSvzAqJfQzYYY0P5N0ir2/cKIPX+Rx32R2xI8UeKFjtWRQ/TKGobml7QeZ0rT2WetV4n/1bx+tnXEPKKWLqjQVmG3vsrnSdwx3sG+bA9pprdoKA5msnY48xs+Il50Y3tF1lrjNq7X8/vbnlmx0khPgYw2cHEdBYWEa2zzJH24wAYIwODOOaoPjjFxd1P3EjEoeLkgaLVH7snVR383z1uywJnNiZdqgb9eA2FudkXY3lwYw0m9oiQIBEWYMwg+5Wj0Ci873NMRxDrx89rwEguFVpwV1p/Pn5nbKWFPYKtzUuYjUzTlPgq61I41k68eTdLAX812n98aaT0WrKQDAYrf5rIQ== dansman805@gmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfwgpqltLWclpAKBbC6CUBxZt1oqsuVSXCDZ+w7Lh09 abigail@dogbuilt.net"
  ];
}
