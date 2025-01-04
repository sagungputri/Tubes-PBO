    package models;

    import java.lang.reflect.Field;
    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Statement;
    import java.util.ArrayList;

    /**
     *
     * 
     * @param <E>
     */
    public abstract class Model<E> {

        Connection con;
        private Statement stmt;
        private boolean isConnected;
        private String message;
        protected String table;
        protected String primaryKey;
        protected String select = "*";
        private String where = "";
        private String join = "";
        private String otherQuery = "";

        public void connect() {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3307/registrasi", "root", "");
        stmt = con.createStatement();
        isConnected = true;
        message = "Database Terkoneksi";
    } catch (ClassNotFoundException | SQLException e) {
        isConnected = false;
        stmt = null; 
        message = "Database connection failed: " + e.getMessage();
    }
}


        public void disconnect() {
    try {
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        message = e.getMessage();
    }
}


        public void insert() {
            try {
                connect();
                String cols = "", values = "";
                for (Field field : this.getClass().getDeclaredFields()) {
                    field.setAccessible(true);
                    Object value = field.get(this);
                    if (value != null) {
                        cols += field.getName() + ", ";
                        values += value + "', '";
                    }
                }
                int result = stmt.executeUpdate("INSERT INTO " + table + "(" + cols.substring(0, cols.length() - 2) + ")"
                                                + " VALUES ('" + values.substring(0, values.length() - 4) + "')");
                message = "info insert: " + result + " rows affected";
            } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
        }

        public void update() {
            try {
                connect();
                String values = "";
                Object pkValue = 0;
                for (Field field : this.getClass().getDeclaredFields()) {
                    field.setAccessible(true);
                    Object value = field.get(this);
                    if (field.getName().equals(primaryKey)) pkValue = value;
                    else if (value != null) {
                        values += field.getName() + " = '" + value + "', ";
                    }
                }
                int result = stmt.executeUpdate("UPDATE " + table + " SET " + values.substring(0, values.length() - 2)
                                                + " WHERE " + primaryKey + " = '" + pkValue +"'");
                message = "info update: " + result + " rows affected";
            } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
        }

        public void delete() {
            try {
                connect();
                Object pkValue = 0;
                for (Field field : this.getClass().getDeclaredFields()) {
                    field.setAccessible(true);
                    if (field.getName().equals(primaryKey)) {
                        pkValue = field.get(this);
                        break;
                    }
                }
                int result = stmt.executeUpdate("DELETE FROM " + table + " WHERE " + primaryKey + " = '" + pkValue +"'");
                message = "info delete: " + result + " rows affected";
            } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
        }

        ArrayList<Object> toRow(ResultSet rs) {
            ArrayList<Object> res = new ArrayList<>();
            int i = 1;
            try {
                while (true) {
                    res.add(rs.getObject(i));
                    i++;
                }
            } catch(SQLException e) {

            }
            return res;
        }

        public ArrayList<ArrayList<Object>> query(String query) {
            ArrayList<ArrayList<Object>> res = new ArrayList<>();
            try {
                connect();
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    res.add(toRow(rs));
                }
            } catch (SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
            return res;
        }

        abstract E toModel(ResultSet rs);

        public ArrayList<E> get() {
            ArrayList<E> res = new ArrayList<>();
            try {
                this.connect();
                String query = "SELECT " +  select + " FROM " + table;
                if (!join.equals("")) query += join;
                if (!where.equals("")) query += " WHERE " + where;
                if (!otherQuery.equals("")) query += " " + otherQuery;
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    res.add(toModel(rs));
                }
            } catch (SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
                select = "*";
                where = "";
                join = "";
                otherQuery = "";
            }
            return res;
        }

        public E find(String pkValue) {
            try {
                connect();
                String query = "SELECT " +  select + " FROM " + table + " WHERE " + primaryKey + " = '" + pkValue +"'";
                ResultSet rs = stmt.executeQuery(query);
                if (rs.next()) {
                    return toModel(rs);
                }
            } catch (SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
                select = "*";
            }
            return null;
        }

        public void select(String cols) {
            select = cols;
        }

        public void join(String table, String on) {
            join += " JOIN " + table + " ON " + on;
        }

        public void where(String cond) {
            where = cond;
        }

        public void addQuery(String query) {
            otherQuery = query;
        }

        public boolean isConnected() {
            return isConnected;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

    }