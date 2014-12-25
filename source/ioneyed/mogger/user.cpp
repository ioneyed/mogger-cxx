/*
 * Copyright (c) 2013, 2014 Corvusoft
 */

//System Includes

//Project Includes
#include "user.h"
//External Includes

//System Namespaces
using namespace mogger;

//Project Namespaces
//External Namespaces

namespace mogger
{
    mogger::User::User(std::string id, std::string name, std::string email){
        m_id = id;
        m_name = name;
        m_email = email;
    }
    mogger::User::User(Json::Value result){
        m_id = result.get("id","").asString();
        m_name = result.get("name","").asString();
        m_email = result.get("email","").asString();
    }
    std::string mogger::User::get_id( void ) const{
        return m_id;
    }
    std::string mogger::User::get_name( void ) const{
        return m_name;
    }
    std::string mogger::User::get_email( void ) const{
        return m_email;
    }
    //Setters
    void mogger::User::set_id( std::string &id){
        m_id=id;
    }
    void mogger::User::set_name( std::string &name){
        m_name = name;
    }
    void mogger::User::set_email( std::string &email){
        m_email = email;
    }
    //Operators
}
