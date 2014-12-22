#include <string>
#include <stdlib.h>
#include <typeinfo>
#include "../dependency/restbed/distribution/include/restbed"
#include <iostream>
#include <pqxx/pqxx>
#include <json/json.h>

using namespace std;
using namespace restbed;
using namespace pqxx;


pqxx::connection C("dbname=promotion_dev user=promotion_dev password=promotion_dev hostaddr=127.0.0.1 port=5432");

/*
class IJsonSerializable
{
public:
    virtual ~IJsonSerializable( void ) {};
    virtual void Serialize( Json::Value& root ) =0;
    virtual void Deserialize( Json::Value& root) =0;
};

class Person : public IJsonSerializable
{
public:
    Person(unsigned id, const std::string& name, const std::string& email );
    virtual ~Person();
    virtual void Serialize( Json::Value& root );
    virtual void Deserialize( Json::Value& root);

private:
    int           id;
    std::string   name;
    std::string   email;

    void Person::Serialize( Json::Value& root )
    {
        // serialize primitives
        root["id"] = id;
        root["name"] = name;
        root["email"] = email;
    }

    void Person::Deserialize( Json::Value& root )
    {
        // deserialize primitives
        id = root.get("id",0).asInt();
        name = root.get("name", 0.0).asString();
        email = root.get("email", "").asString();
    }
};
class CJsonSerializer
{
public:
    //static bool Serialize( IJsonSerializable* pObj, std::string& output );
    //static bool Deserialize( IJsonSerializable* pObj, std::string& input );

private:
    CJsonSerializer( void ) {};

    bool CJsonSerializer::Serialize( IJsonSerializable* pObj, std::string& output )
    {
        if (pObj == NULL)
            return false;

        Json::Value serializeRoot;
        pObj->Serialize(serializeRoot);

        Json::StyledWriter writer;
        output = writer.write( serializeRoot );

        return true;
    }

    bool CJsonSerializer::Deserialize( IJsonSerializable* pObj, std::string& input )
    {
        if (pObj == NULL)
            return false;

        Json::Value deserializeRoot;
        Json::Reader reader;

        if ( !reader.parse(input, deserializeRoot) )
            return false;

        pObj->Deserialize(deserializeRoot);

        return true;
    }
};
*/
Response get_method_handler( const Request& request )
{
    try {
        string sql;
        /* Create SQL statement */
        sql = "SELECT * from users";

        /* Create a non-transactional object. */
        nontransaction N(C);

        /* Execute SQL query */
        result R( N.exec( sql ));

        string body;
        body+="{ \"items\":[";
        /* List down all the records */
        for (result::const_iterator c = R.begin(); c != R.end(); ++c) {
            //Person p = new Person(c[0].as<int>(), c[1].as<string>(), c[2].as<string>());
            std::string output;
            //CJsonSerializer::Serialize(&p, output);
            clog << output << endl;
            clog << c[0].as<string>() << std::endl;
            clog << c[1].as<string>() << std::endl;
            clog << c[2].as<string>() << std::endl;
            body+="{\"id\":" + c[0].as<string>();
            body+="\"name\":" + c[1].as<string>();
            body+="\"email\":" + c[2].as<string>();
            body+="},";
        }
        body+="]}";
        C.disconnect ();

        Response response;
        response.set_body( body );
        response.set_status_code( StatusCode::OK );

        return response;
    }catch (const std::exception &e){
        clog << e.what() << std::endl;
        Response resp;
        resp.set_body("Erro");
        resp.set_status_code(StatusCode::OK);
        return resp;
    }
}

int main( int argc, char *argv[])
{

    string tableName("tabletwo");

    if (C.is_open()) {
        cout << "We are connected to" << C.dbname() << endl;

    } else {
        cout << "We are not connected!" << endl;
        return 0;
    }
    Resource resource;
    resource.set_path( "/resource/{name: .*}" );
    resource.set_method_handler( "GET", &get_method_handler );

    Settings settings;
    if(argc==2) {

            if (atoi(argv[1]) > 0 && atoi(argv[1]) <= 65535) {
                clog << argv[0] << " is running on port: " << argv[1];
                settings.set_port(atoi(argv[1]));
            } else {
                clog << "Invalid Port Number\n";
                return 0;
            }

    }else{
        clog << argv[0] << " is running on port: " << 1984;
        settings.set_port(1984);
    }
    
    Service service( settings );
    service.publish( resource );
    service.start( );

    return EXIT_SUCCESS;
}
