/***
    Copyright (C) 2010 Jordi Puigdellívol <jordi@gloobus.net>
    Copyright (c) 2017 elementary LLC.

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU Lesser General Public License version 3, as published
    by the Free Software Foundation.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranties of
    MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
    PURPOSE. See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program. If not, see <http://www.gnu.org/licenses/>.

    Authors: Jordi Puigdellívol <jordi@gloobus.net>
             ammonkey <am.monkeyd@gmail.com>
             Jeremy Wootten <jeremy@elementaryos.org>
***/

    void on_bus_aquired (DBusConnection conn, string n) {
        try {
            string name = "/org/pantheon/files/db";
            var object = new MarlinTags ();
            conn.register_object (name, object);
            debug ("MarlinTags object registered with dbus connection name %s", name);
        } catch (IOError e) {
            error ("Could not register MarlinTags service");
        }
    }

    // Exit C function to quit the loop
    extern void exit (int exit_code);

    void on_name_lost (DBusConnection connection, string name) {
        critical ("Name %s was not acquired", name);
        exit (-1);
    }

    void main () {
        Bus.own_name (BusType.SESSION, "org.pantheon.files.db", BusNameOwnerFlags.NONE,
                      on_bus_aquired,
                      () => {},
                      on_name_lost);

        new MainLoop ().run ();
    }
