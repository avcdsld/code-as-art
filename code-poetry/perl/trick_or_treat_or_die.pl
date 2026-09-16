my $choice;

sub halloween {
  $choice = shift;
  trick() or treat() or die;
}

sub trick {
  $choice eq 'trick';
}

sub treat {
  $choice eq 'treat';
}
