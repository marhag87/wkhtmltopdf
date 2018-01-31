Name:          wkhtmltopdf
Version:       0.12.4
Release:       1%{?dist}
Epoch:         1
Summary:       Simple shell utility to convert html to pdf

Group:         Unspecified
License:       GPLv3+
URL:           http://wkhtmltopdf.org/
Source0:       https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/%{version}/wkhtmltox-%{version}_linux-generic-amd64.tar.xz#/%{name}-%{version}.tar.xz

# Don't build debug package
%define debug_package %{nil}

%description
Simple shell utility to convert html to pdf using the webkit
rendering engine, and qt.

%prep
%setup -q -c

%build

%install
install -p -d -m 0755 %{buildroot}%{_bindir}
install -p -d -m 0755 %{buildroot}%{_libdir}
install -p -d -m 0755 %{buildroot}%{_mandir}/man1
cp wkhtmltox/bin/* %{buildroot}%{_bindir}/
cp wkhtmltox/lib/libwkhtmltox.so* %{buildroot}%{_libdir}/
cp wkhtmltox/share/man/man1/* %{buildroot}%{_mandir}/man1/

%files
%{_bindir}/wkhtmltoimage
%{_bindir}/wkhtmltopdf
%{_libdir}/libwkhtmltox.so*
%doc
%{_mandir}/man1/wkhtmlto*

%changelog
* Wed Jan 31 2018 Martin Hagstrom <marhag87@gmail.com> 0.12.4-1
- Initial release
