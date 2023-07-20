@AbapCatalog.sqlViewName: 'ZMGBV_BOOKSUPLL'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Suplemento de reserva de vuelo'
define view zmgbi_booksuppl
  as select from zmgbt_booksuppl as BookingSupplement
  association        to parent zmgbi_booking  as _Booking        on  $projection.travel_id  = _Booking.travel_id
                                                                 and $projection.booking_id = _Booking.booking_id
  association [1..1] to zmgbi_travel          as _Travel         on  $projection.travel_id = _Travel.travel_id
  association [1..1] to /DMO/I_Supplement     as _Product        on  $projection.supplement_id = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText as _SupplementText on  $projection.supplement_id = _SupplementText.SupplementID

{

  key travel_id,
  key booking_id,
  key booking_supplement_id,
      supplement_id,
      @Semantics.amount.currencyCode: 'currency'
      prive,
      @Semantics.currencyCode: true
      currency,
      _Booking,
      _Travel,
      _Product,
      _SupplementText
}
