/*
 * Copyright (c) 2014 Ioneyed
 */

#ifndef _MOGGER_USER_H
#define _MOGGER_USER_H 1

//System Includes
#include <map>
#include <string>
#include <pqxx/pqxx>
#include <json/json.h>

namespace mogger {

    //Forward Declarations

    class User
    {
        public:


//Friends
            //Definitions

            //Constructors
            User(std::string id, std::string name, std::string email);
            User(Json::Value result);

            //Functionality
            virtual void Serialize( Json::Value& root );
            virtual void Deserialize( Json::Value& root);
            //Getters
            std::string get_id( void ) const;
            std::string get_name ( void ) const;
            std::string get_email( void ) const;
            //Setters
            void set_id( std::string& );
            void set_name( std::string&);
            void set_email( std::string&);
            //Operators
            //Properties

            ~User(){

            }


        protected:
            //Friends

            //Constructors
            //Definitions

            //Functionality

            //Getters

            //Setters

            //Operators

            //Properties

        private:
            //Friends

            //Definitions
            std::string m_id;
            std::string m_name;
            std::string m_email;
            //Constructors
            User(){ }
            //Functionality

            //Getters

            //Setters

            //Operators

            //Properties
    };
};
#endif