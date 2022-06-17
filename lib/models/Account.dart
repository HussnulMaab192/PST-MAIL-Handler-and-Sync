// ignore_for_file: non_constant_identifier_names

class Account {
  late int acc_id;
  late String acc_type;
  late String acc_mail;
  late String acc_pswd;
  late String cnfrm_pswd;
  late String smtp;
  late int smtpPort;
  late String imap;
  late int imapPort;

  Account(
    this.acc_id,
    this.acc_type,
    this.acc_mail,
    this.acc_pswd,
    this.cnfrm_pswd,
    this.smtp,
    this.smtpPort,
    this.imap,
    this.imapPort,
  );
  // int getId()
  // {
  //   return id;
  // }

  int getid() => acc_id;
  String getype() => acc_type;
  String getmail() => acc_mail;
  String getPswd() => acc_pswd;
  String getCnfrmPswd() => cnfrm_pswd;
  String getSmtp() => smtp;
  int getSmtpPort() => smtpPort;
  int getImapPort() => imapPort;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['id'] = acc_id;
    mp['type'] = acc_type;
    mp['email'] = acc_mail;
    mp['pass'] = acc_pswd;
    mp['confirm_password'] = cnfrm_pswd;
    mp['smtp_server'] = smtp;
    mp['smtp_port'] = smtpPort;
    mp['imap_server'] = imap;
    mp['imap_port'] = imapPort;

    return mp;
  }

  Account.fromMap(Map<String, dynamic> map) {
    acc_id = map['id'];
    acc_type = map['type'];
    acc_mail = map['email'];
    acc_pswd = map['pass'];
    cnfrm_pswd = map['confirm_password'];
    smtp = map['smtp_server'];
    smtpPort = map['smtp_port'];
    imap = map['imap_server'];
    imapPort = map['imap_port'];
  }
}
