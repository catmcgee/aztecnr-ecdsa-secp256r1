contract WebAuthnVerifier {
  use dep::std::ecdsa_secp256r1;
  use dep::aztec::{
    context::{PrivateContext, PublicContext, Context},
    state_vars::public_state::PublicState,
    types::type_serialization::bool_serialization::{BoolSerializationMethods, BOOL_SERIALIZED_LEN}
  };

  struct Storage {
    verified: PublicState<bool, BOOL_SERIALIZED_LEN>
  }
  impl Storage {
        fn init(context: Context) -> pub Self {
            Storage {
                verified: PublicState::new(context, 1, BoolSerializationMethods)
            }
        }
    }

  #[aztec(private)]
  fn constructor() {
  }
  
  #[aztec(public)]
  fn do_verify_signature(_public_key_x: [u8; 32],
    _public_key_y: [u8; 32],
    _signature: [u8; 64],
    _message_hash: [u8; 32]) {
    let test = ecdsa_secp256r1::verify_signature(_public_key_x, _public_key_y, _signature, _message_hash);
    storage.verified.write(!test);

  }

  unconstrained fn was_verified() -> bool {
    storage.verified.read()
  }

  unconstrained fn compute_note_hash_and_nullifier(contract_address: Field, nonce: Field, storage_slot: Field, serialized_note: [Field; 0]) -> [Field; 4] {
      [0, 0, 0, 0]
  }
}