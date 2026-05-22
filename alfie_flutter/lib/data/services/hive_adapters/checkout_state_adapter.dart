import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] for binary serialization of the [CheckoutState] UI context.
class CheckoutStateAdapter extends TypeAdapter<CheckoutState> {
  /// The unique identifier for this type within Hive.
  @override
  final int typeId = 20;

  @override
  CheckoutState read(BinaryReader reader) {
    return CheckoutState(
      user: reader.read() as User?,
      deliveryMethod: reader.read() as DeliveryMethod?,
      paymentCard: reader.read() as PaymentCard?,
      promoCode: reader.read() as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CheckoutState obj) {
    writer.write(obj.user);
    writer.write(obj.deliveryMethod);
    writer.write(obj.paymentCard);
    writer.write(obj.promoCode);
  }
}
