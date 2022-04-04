package com.namyang.nyorder.comm.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class AccountContext  extends User {

    private final AccountVO account;

    public AccountContext(AccountVO account, Collection<? extends GrantedAuthority> authorities) {
        super(account.getUsername(), account.getPassword(), authorities);
        this.account = account;
    }

    public AccountVO getAccount() {
        return account;
    }
}