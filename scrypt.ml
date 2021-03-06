exception Scrypt_error of int
let _ = Callback.register_exception "Scrypt_error" (Scrypt_error 0)

external scryptenc_buf : string -> string -> int -> float -> float -> string = "scryptenc_buf_stub"
external scryptdec_buf : string -> string -> int -> float -> float -> string = "scryptdec_buf_stub"

(* Default values for optional arguments are chosen to match the scrypt command line utility. *)

let encrypt_exn ?(maxmem=0) ?(maxmemfrac=0.125) ?(maxtime=5.0) data passwd =
  scryptenc_buf data passwd maxmem maxmemfrac maxtime

let encrypt ?(maxmem=0) ?(maxmemfrac=0.125) ?(maxtime=5.0) data passwd=
  try Some (encrypt_exn ~maxmem ~maxmemfrac ~maxtime data passwd)
  with Scrypt_error _ -> None

let decrypt_exn ?(maxmem=0) ?(maxmemfrac=0.5) ?(maxtime=300.0) cyphertext passwd =
  scryptdec_buf cyphertext passwd maxmem maxmemfrac maxtime

let decrypt ?(maxmem=0) ?(maxmemfrac=0.5) ?(maxtime=300.0) cyphertext passwd =
  try Some (decrypt_exn ~maxmem ~maxmemfrac ~maxtime cyphertext passwd)
  with Scrypt_error _ -> None
