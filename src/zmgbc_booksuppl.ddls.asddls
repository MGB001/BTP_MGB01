@EndUserText.label: 'Consumo Reserva suplemento'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zmgbc_booksuppl
  as projection on zmgbi_booksuppl
{
  key travel_id                   as TravelID,
  key booking_id                  as BookingID,
  key booking_supplement_id       as BookingSupplementID,
      @ObjectModel.text.element:  ['SupplementDescription']
      supplement_id               as SupplementID,
      _SupplementText.Description as SupplementDescription : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      prive                       as Price,
      @Semantics.currencyCode: true
      currency                    as CurrencyCode,
      /* Associations */
      _Travel  : redirected to zmgbc_travel,
      _Booking : redirected to parent zmgbc_booking,
      _Product,
      _SupplementText

}
